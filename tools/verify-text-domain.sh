#!/bin/sh

set -eu

fail() {
	printf '%s\n' "$1" >&2
	exit 1
}

repository_root=$( git rev-parse --show-toplevel 2>/dev/null ) || {
	fail 'Text-domain check must run inside a Git worktree.'
}

cd "$repository_root"

plugin_dir='plugins/basicrum'
plugin_file="$plugin_dir/basicrum.php"
expected_domain='basicrum-real-user-monitoring'
expected_pot="$plugin_dir/languages/${expected_domain}.pot"
legacy_pot="$plugin_dir/languages/basicrum.pot"
composer_file="$plugin_dir/composer.json"

header_domain=$( sed -n 's/^[[:space:]]*\*[[:space:]]*Text Domain:[[:space:]]*\([^[:space:]]*\)[[:space:]]*$/\1/p' "$plugin_file" )

if [ "$header_domain" != "$expected_domain" ]; then
	fail "Plugin header text domain must be $expected_domain, found ${header_domain:-none}."
fi

if [ ! -f "$expected_pot" ]; then
	fail "Translation template is missing: $expected_pot"
fi

if [ -e "$legacy_pot" ]; then
	fail "Legacy translation template must be removed: $legacy_pot"
fi

if ! grep -Fq -- "--domain=$expected_domain" tools/update-translations.sh; then
	fail 'Translation generation does not use the WordPress.org text domain.'
fi

if ! grep -Fq -- "\"installer-name\": \"$expected_domain\"" "$composer_file"; then
	fail 'Composer installer-name does not match the WordPress.org slug.'
fi

if ! grep -Fq "<element value=\"$expected_domain\" />" "$plugin_dir/phpcs.ruleset.xml"; then
	fail 'WPCS is not configured with the WordPress.org text domain.'
fi

legacy_literals=$(
	grep -nHE "['\"]basicrum['\"]" \
		"$plugin_file" \
		"$plugin_dir"/src/*.php \
		"$plugin_dir"/src/Admin/*.php \
		"$plugin_dir"/src/Admin/Settings/*.php \
		2>/dev/null \
		| grep -v "^$plugin_dir/src/Compatibility.php:" \
		| grep -v "^$plugin_dir/src/Admin/Settings/Page.php:.*const SLUG = 'basicrum';" \
		|| true
)

if [ -n "$legacy_literals" ]; then
	printf '%s\n' 'Unexpected legacy text-domain literal found:' >&2
	printf '%s\n' "$legacy_literals" >&2
	exit 1
fi

printf '%s\n' "Text-domain check passed: $expected_domain"
