#!/usr/bin/env sh

set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
REPOSITORY_ROOT=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
PLUGIN_DIR=${1:-"$REPOSITORY_ROOT/plugins/basicrum"}
RELEASE_DIR=${2:-"$REPOSITORY_ROOT/release"}
PLUGIN_SLUG=basicrum-real-user-monitoring
ARCHIVE_NAME="${PLUGIN_SLUG}.zip"
ARCHIVE_PATH="$RELEASE_DIR/$ARCHIVE_NAME"
CHECKSUM_PATH="$ARCHIVE_PATH.sha256"

if [ ! -f "$PLUGIN_DIR/basicrum.php" ] || [ ! -f "$PLUGIN_DIR/.distignore" ]; then
	printf '%s\n' "Plugin source is incomplete: $PLUGIN_DIR" >&2
	exit 1
fi

for required_command in composer rsync zip; do
	if ! command -v "$required_command" >/dev/null 2>&1; then
		printf '%s\n' "Required command is not installed: $required_command" >&2
		exit 1
	fi
done

mkdir -p "$RELEASE_DIR"
STAGING_DIR=$(mktemp -d "${TMPDIR:-/tmp}/basicrum-release.XXXXXX")

cleanup() {
	rm -rf "$STAGING_DIR"
}

trap cleanup EXIT HUP INT TERM

BUILD_DIR="$STAGING_DIR/build"
PACKAGE_DIR="$STAGING_DIR/package"

mkdir -p "$BUILD_DIR" "$PACKAGE_DIR/$PLUGIN_SLUG"
rsync -rc \
	--delete \
	--exclude='/vendor/' \
	"$PLUGIN_DIR/" \
	"$BUILD_DIR/"

(
	cd "$BUILD_DIR"
	composer install \
		--no-dev \
		--no-interaction \
		--no-progress \
		--prefer-dist \
		--classmap-authoritative
)

# composer/installers only places this package when a Composer project installs
# it as a dependency. It has no role inside an installed plugin, so remove it
# from the staged tree so that the shipped vendor directory, class map, and
# Composer metadata all agree, then restore the manifest the repository ships.
(
	cd "$BUILD_DIR"
	composer remove composer/installers \
		--no-interaction \
		--no-progress \
		--no-plugins \
		--no-scripts \
		--update-no-dev \
		--classmap-authoritative
)

cp "$PLUGIN_DIR/composer.json" "$BUILD_DIR/composer.json"

rsync -rc \
	--delete \
	--delete-excluded \
	--exclude-from="$PLUGIN_DIR/.distignore" \
	"$BUILD_DIR/" \
	"$PACKAGE_DIR/$PLUGIN_SLUG/"

rm -f "$ARCHIVE_PATH" "$CHECKSUM_PATH"
(
	cd "$PACKAGE_DIR"
	zip -qr "$ARCHIVE_PATH" "$PLUGIN_SLUG"
)

if command -v sha256sum >/dev/null 2>&1; then
	(
		cd "$RELEASE_DIR"
		sha256sum "$ARCHIVE_NAME" > "$ARCHIVE_NAME.sha256"
	)
elif command -v shasum >/dev/null 2>&1; then
	(
		cd "$RELEASE_DIR"
		shasum -a 256 "$ARCHIVE_NAME" > "$ARCHIVE_NAME.sha256"
	)
else
	printf '%s\n' 'Neither sha256sum nor shasum is installed.' >&2
	exit 1
fi

sh "$SCRIPT_DIR/verify-release.sh" "$ARCHIVE_PATH"

printf '%s\n' "Release archive: $ARCHIVE_PATH"
printf '%s\n' "SHA-256 checksum: $CHECKSUM_PATH"
