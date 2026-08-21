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

repository_root=$( git rev-parse --show-toplevel 2>/dev/null ) || {
	fail 'Plugin identity check must run inside a Git worktree.'
}

cd "$repository_root"

plugin_dir='plugins/basicrum'
plugin_file="$plugin_dir/basicrum.php"
readme_file="$plugin_dir/readme.txt"

plugin_name=$( require_single_value 'plugin header Plugin Name value' "$(
	sed -n 's/^[[:space:]]*\*[[:space:]]*Plugin Name:[[:space:]]*\(.*[^[:space:]]\)[[:space:]]*$/\1/p' "$plugin_file"
)" )

text_domain=$( require_single_value 'plugin header Text Domain value' "$(
	sed -n 's/^[[:space:]]*\*[[:space:]]*Text Domain:[[:space:]]*\([^[:space:]]*\)[[:space:]]*$/\1/p' "$plugin_file"
)" )

readme_name=$( require_single_value 'readme plugin name' "$(
	sed -n 's/^===[[:space:]]*\(.*[^[:space:]]\)[[:space:]]*===$/\1/p' "$readme_file"
)" )

generated_slug=$(
	printf '%s\n' "$plugin_name" |
		LC_ALL=C tr '[:upper:]' '[:lower:]' |
		sed -E 's/[^a-z0-9]+/-/g; s/^-+//; s/-+$//'
)

directory_slug=$( basename "$plugin_dir" )

if [ "$generated_slug" != "$text_domain" ]; then
	fail "Plugin Name generates WordPress.org slug '$generated_slug', but Text Domain is '$text_domain'."
fi

if [ "$directory_slug" != "$text_domain" ]; then
	fail "Plugin directory slug ($directory_slug) does not match Text Domain ($text_domain)."
fi

if [ "$readme_name" != "$plugin_name" ]; then
	fail "Readme plugin name ($readme_name) does not match plugin header Plugin Name ($plugin_name)."
fi

printf '%s\n' "Plugin identity check passed: $plugin_name ($text_domain)"
