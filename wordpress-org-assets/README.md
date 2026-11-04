# WordPress.org Plugin Directory assets

These files are prepared for the Basicrum listing in the WordPress.org Plugin
Directory. When publishing through the WordPress.org SVN repository, copy them
to its top-level `assets/` directory, alongside `trunk/`.

- `icon-128x128.png` and `icon-256x256.png` are the directory icons.
- `banner-772x250.png` and `banner-1544x500.png` are the directory banners.
- `screenshot-1.png` through `screenshot-4.png` are the numbered directory
  screenshots whose captions are defined in `plugins/basicrum/readme.txt`.

The canonical source artwork is
`plugins/basicrum/assets/images/basicrum-logo.png`, which the settings page
uses at runtime.

The banners combine that logo with a Chrome capture of the public Basicrum
Core Web Vitals demo and a compact page-breakdown detail based on a supplied
screenshot. The captures and `design-reference/build-banner.py` are kept under
`design-reference/` so the artwork can be revised. The builder requires Pillow
and the macOS Arial fonts. Keep the design references out of the WordPress.org
SVN assets directory; only the named banners, icons, and screenshots belong there.

This directory remains outside `plugins/basicrum/`, so the release build does
not include these WordPress.org-only files in the installable Basicrum ZIP. See
[Plugin Assets](https://developer.wordpress.org/plugins/wordpress-org/plugin-assets/)
for the directory requirements.
