#!/bin/sh

set -eu

fail() {
	printf '%s\n' "$1" >&2
	exit 1
}

require_single_value() {
	label=$1
	value=$2

	if [ -z "$value" ]; then
		fail "Could not find $label."
	fi

	line_count=$( printf '%s\n' "$value" | awk 'END { print NR }' )

	if [ "$line_count" -ne 1 ]; then
		fail "Expected exactly one $label, found $line_count."
	fi

	printf '%s\n' "$value"
}

lock_package_version() {
	package_name=$1

	awk -v package_key="\"node_modules/${package_name}\": {" '
		index($0, package_key) {
			in_package = 1
			next
		}

		in_package && match($0, /"version": "[^"]+"/) {
			version = substr($0, RSTART, RLENGTH)
			sub(/^"version": "/, "", version)
			sub(/"$/, "", version)
			print version
			exit
		}
	' package-lock.json
}

repository_root=$( git rev-parse --show-toplevel 2>/dev/null ) || {
	fail 'Playwright consistency check must run inside a Git worktree.'
}

cd "$repository_root"

for required_file in package.json package-lock.json docker-compose.yml docker/woocommerce-e2e.yml; do
	if [ ! -f "$required_file" ]; then
		fail "Required Playwright metadata file is missing: $required_file"
	fi
done

package_version=$( require_single_value '@playwright/test package version' "$(
	sed -n 's/^[[:space:]]*"@playwright\/test":[[:space:]]*"\([^"]*\)",*[[:space:]]*$/\1/p' package.json
)" )

if ! printf '%s\n' "$package_version" | grep -Eq '^[0-9]+\.[0-9]+\.[0-9]+$'; then
	fail "@playwright/test must use an exact X.Y.Z version, found $package_version."
fi

for lock_package in '@playwright/test' playwright playwright-core; do
	lock_version=$( require_single_value "$lock_package lockfile version" "$( lock_package_version "$lock_package" )" )

	if [ "$lock_version" != "$package_version" ]; then
		fail "$lock_package lockfile version ($lock_version) does not match @playwright/test ($package_version)."
	fi
done

expected_image="mcr.microsoft.com/playwright:v${package_version}-noble"
expected_digest=''

for compose_file in docker-compose.yml docker/woocommerce-e2e.yml; do
	image=$( require_single_value "$compose_file Playwright image" "$(
		sed -n 's/^[[:space:]]*image:[[:space:]]*\(mcr\.microsoft\.com\/playwright:[^[:space:]]*\)[[:space:]]*$/\1/p' "$compose_file"
	)" )

	case "$image" in
		"${expected_image}@sha256:"*)
			;;
		*)
			fail "$compose_file must use ${expected_image} with an immutable SHA-256 digest, found $image."
			;;
	esac

	digest=${image##*@sha256:}

	if ! printf '%s\n' "$digest" | grep -Eq '^[0-9a-f]{64}$'; then
		fail "$compose_file has an invalid Playwright image digest: $digest"
	fi

	if ! grep -Fq "# Reviewed tag: $expected_image" "$compose_file"; then
		fail "$compose_file does not document the reviewed Playwright tag $expected_image."
	fi

	if [ -z "$expected_digest" ]; then
		expected_digest=$digest
	elif [ "$digest" != "$expected_digest" ]; then
		fail "Playwright Docker image digests differ: $expected_digest and $digest."
	fi
done

printf '%s\n' "Playwright consistency check passed: $package_version sha256:$expected_digest"
