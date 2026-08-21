# WordPress.org Submission Checklist (2026-07-19)

Factuality and ambiguity audit of the submission surfaces (readme.txt,
basicrum.php header, wordpress-org-assets, release ZIP) at version 0.0.8,
ahead of the plugin-directory submission. Method: four auditors (line-by-line
readme factuality vs code, current wp.org handbook requirements, two-persona
ambiguity sweep, hands-on official readme validator + reviewer-style ZIP
inspection); every non-clean verdict adversarially re-checked by two
refuters. 84 claims audited: 52 clean, 24 upheld findings, 8 overturned.

## 1. Blockers - must be resolved before submission

- [x] RESOLVED 2026-07-20: user registered the wordpress.org account `basicrum`; readme.txt Contributors updated to `basicrum`. Original finding: Contributors username did not exist. The OFFICIAL wp.org readme
  validator returned verbatim: "The following contributors listed were
  ignored, as the WordPress.org user could not be found. tstoychev."
  Register the wordpress.org account with exactly that username (or change
  readme.txt line 2 to the registered account that will submit), and
  confirm profiles.wordpress.org/tstoychev resolves. (D1a, R02, B6)
- [x] RESOLVED 2026-07-20: Boomerang BSD LICENSE.txt now ships at assets/js/boomr/LICENSE.txt; readme.txt Third-party section and THIRD-PARTY-NOTICES.txt name the source commit and repositories. UPGRADED 2026-07-20: build reproduced BYTE-IDENTICAL (SHA-256 90e8a1c8...) from basicrum/boomerang master commit ead2783a with Node 12 + npm ci + grunt clean build --build-flavor=cutting-edge --build-number=815; the in-file banner stamps parent commit 564759ed because the final continuity.js change was uncommitted at original build time - docs now state both hashes; tools/verify-boomerang-provenance.sh guards bundle/docs sync via make conventions. Original finding: human-readable source for the bundled Boomerang (guideline 4:
  reviewers require public, maintained access to source and build tools
  for minified files). assets/js/boomr/ ships only the .min.js; its header
  says "See the accompanying LICENSE.txt" and none accompanies it. Add to
  readme.txt (Development or Third-party section) and THIRD-PARTY-NOTICES.txt:
  the upstream repository, the exact source commit (the bundle header
  carries 564759ed70de7801bb64de5e2025fb6ac049ff5f), and the build
  procedure; ship Boomerang's BSD license text alongside the bundle. (B2)
- [x] RESOLVED 2026-07-20: phpstan.neon.dist added to .distignore and the verify-release dev-file regex; ZIP rebuilt and verified clean. Original finding: dev file leaks into the ZIP: release/basicrum.zip contains
  basicrum/phpstan.neon.dist. Add it to plugins/basicrum/.distignore and
  to the verify-release.sh dev-file regex, rebuild. Plugin Check would
  flag it. (D2a, B7)

## 2. Reviewer-flag items - fix to avoid review friction

- [x] RESOLVED 2026-07-20: External services section added to readme.txt. Original: add an "External services" readme section in the current
  reviewer-requested format: name the service (operator-configured
  collector; basicrum.com hosted option), what data is sent and when
  (performance beacons: URLs, timings, page type, site id; IP and user
  agent visible to the collector), and links to the service terms/privacy
  pages. The FAQ covers parts of this but not in the expected form. (B4)
- [x] RESOLVED 2026-07-20: "Does Basicrum set cookies?" FAQ added (RT named with attributes and lifetime; BA described as legacy removal); RT also named in the Privacy Policy Guide text (Privacy.php) with test assertions. Original: add a cookies FAQ: the readme never names the first-party RT and BA
  cookies the listing's own privacy story depends on ("Does Basicrum set
  cookies?" - names, purpose, consent-mode behavior, opt-out removal).
  (C10)
- [x] RESOLVED 2026-07-20: changelog collapsed to a single first-release entry. Original: collapse the 0.0.8 changelog into a single first-release feature
  entry; the current six bullets describe diffs against never-published
  0.0.x builds and can be misread as shipped-version history. Decide
  whether 0.0.7/0.0.6 entries stay (internal history) or fold in. (C13,
  C14)
- [x] RESOLVED 2026-08-21: Plugin Check 2.1.0 completed against the exact
  `v0.0.9` ZIP built from tagged commit
  `f689a3616e897c07a6dd60c51b4985bebeef2988` (SHA-256
  `7321a346e3e9e8cc0b4c8cd749a8fa8f209614281da5133cdfcd704f98b42197`).
  WP-CLI ran all stable checks in new-submission mode with slug `basicrum`, no
  ignored codes, and Plugin Check's `cli.php` loaded so runtime checks were
  included. Strict and raw-result runs completed successfully with no result
  rows. The earlier `outdated_tested_upto_header` finding was resolved by the
  WordPress 7.1 compatibility update. (B7)
- [x] RESOLVED 2026-08-20: the permanent directory slug is decided. wp.org
  autogenerates the slug from the plugin header Plugin Name at submission and
  cannot rename it after approval, so `Basicrum - Real User Monitoring` will be
  offered `basicrum-real-user-monitoring`. The display name stays descriptive
  and the shorter `basicrum` slug is requested through the documented one-time
  correction: the FAQ states "You can update your slug once after submitting
  it. Every submission gets an automated email with directions." Both
  `basicrum` and `basicrum-real-user-monitoring` were unregistered on
  2026-08-20 (wordpress.org/plugins/<slug>/ redirects to search for each).
  `basicrum` is what the generated POT `Report-Msgid-Bugs-To` and the plugin
  directory name already assume, so taking it keeps the support URL correct.
  This is a user-only action on submission day; see the list below.
- [x] RESOLVED 2026-08-20: External services now links the service privacy
  information guideline 6 and the common-issues page ask for. The Basicrum
  Privacy Notice covers only basicrum.com, its contact form, and beta requests,
  so the readme says exactly that and directs webmasters to request the hosted
  collector's own terms and privacy notice. Publishing those two documents is
  still an open user-only action.
- [x] RESOLVED 2026-08-20: WordPress stable moved to 7.1 and Plugin Check
  now errors on Tested up to below current stable. Integration suite run
  locally against a verified real WordPress 7.1 core (wp_version 7.1,
  4 tests green), blocking rows php 8.4/wp 7.1 and php 8.5/wp 7.1 added to
  ci.yml, readme bumped to Tested up to: 7.1, ZIP rebuilt. GitHub CI must
  confirm the new rows green on push before tagging. (R05)

## 3. Ambiguity fixes - upheld copy issues

- [x] RESOLVED 2026-07-20: FAQ reworded (hosted account is one way; self-hosted needs no account). Original: account FAQ answered "Yes." then contradicts
  itself: self-hosted collectors need no account. Reword: collector
  endpoint + Brum Site ID required; hosted account is one way to get
  them. (R24, C04)
- [x] Vocabulary bridge: the compliance FAQ says "immediate and
  consent-controlled loading" while the settings radios say "Monitor
  without consent" / "Require consent before monitoring". Bridge both
  vocabularies once, then use the radio labels. Resolved by removing the
  competing terminology. (C02)
- [x] Define the server-side nouns once: collector (receives beacons) vs
  backoffice (dashboard where the Brum Site ID lives) vs account (hosted
  option); "backoffice" is currently undefined jargon. Resolved by using
  collector, Beacon URL, and hosted service consistently. (C15)
- [x] Disambiguate "Basicrum" = plugin vs company vs service in the
  query-string FAQ: data goes only to the operator-configured Beacon URL;
  the plugin makes no requests to basicrum.com. (C16)
- [x] HTTP Strictness FAQ still inverts the semantics (enabling
  "Strictness" relaxes enforcement). Rewrite the FAQ to lead with the
  default (auto-upgrade to HTTPS) and what the toggle actually allows;
  the label rename remains open from the operator-experience audit. (C08)
- [x] RESOLVED 2026-08-20: immediate-mode sentence now says "frontend
  pages" with the administrator exclusion spelled out; PrivacyTest pins
  both phrases. (C12)
- [x] Define "connected" CookieYes at first use. Resolved by removing the
  ambiguous implementation detail from the customer-facing overview. (C07)
- [x] Replace "fails closed" jargon with plain language. (C19)
- [x] Align the installation order with the enabled-field dependency and
  remove the redundant "How it works" sequence. (C22)
- [x] Remove the undefined Script Position forward reference from the
  consent overview. (C23)

## 4. Optional but recommended

- [x] Screenshots: four current WordPress 7.0.2 settings captures use the exact
  Visitor Consent and Consent Tool Connection labels, privacy-safe example
  values, and matching numbered captions in `readme.txt`. (C24)
- [x] RESOLVED 2026-08-20: both URLs return HTTP 200. (R45)
- [x] RESOLVED: readme now says "CookieYes 3.x". (C06)

## 5. Verified clean (highlights)

- [x] Version consistency: header, BASICRUM_VERSION, Stable tag, top
  changelog all 0.0.8; no git tags, consistent with first release. (R07)
- [x] Short description 95 chars (under 150), byte-identical to the
  header Description; privacy-first claim backed by defaults. (R09, C01
  overturned)
- [x] SUPERSEDED 2026-08-20: relicensed from MIT to GPLv2-or-later so the
  listing matches the license guideline 1 recommends. GPLv2 text now ships in
  LICENSE and plugins/basicrum/LICENSE.md; header, readme, composer.json
  (`GPL-2.0-or-later`), THIRD-PARTY-NOTICES.txt, root README, and the
  regenerated POT all agree. Boomerang stays BSD and GPL-compatible, and
  THIRD-PARTY-NOTICES.txt still scopes it out of the Basicrum license.
  Original finding: MIT declared consistently and GPL-compatible. (R08, B1)
- [x] All five tags valid and implemented; Requires at least 6.0 and
  Requires PHP 7.4 match headers, composer, and CI matrix. (R03, R04, R06)
- [x] Feature claims verified against code: page-type values verbatim in
  PageTypeDetector.php with correctly hedged non-exhaustive lists;
  detection markers and version floors match ConsentIntegration.php;
  cache-plugin list matches Compatibility.php; guideline 7 satisfied
  (off by default, consent-controlled default). (R12-R15, B4-part)
- [x] Plugin header complete: Requires at least, Requires PHP, Text
  Domain, Domain Path present; validator returned only the Contributors
  warning - readme parses cleanly otherwise. (D1a)
- [x] ZIP contents otherwise reviewer-clean: no repo README, tests,
  docs/, node_modules, or scratch; readable+minified loader pairs and all
  five adapters present; production-only vendor/. (D2)

## User-only actions before submission day

1. Register/confirm the wordpress.org username matching Contributors.
2. Re-confirm WordPress 7.1 is the current released stable.
3. Verify basicrum.com pages linked from the listing are live.
4. Publish the hosted-service Terms of Service and a privacy notice that covers
   the hosted collector, then link both from the readme External services
   section. See docs/privacy-policy-preparation-checklist.md steps 14 and 15.
5. Confirm the two outside code contributors are content with the GPLv2-or-later
   relicense. MIT permits the sublicense, so this is a courtesy record, not a
   blocker.
6. On the submission email, use the one-time slug update to change
   `basicrum-real-user-monitoring` to `basicrum` before approval. The slug is
   permanent afterwards, and it also sets the SVN path, the installed folder
   name, and the support URL the POT already points at. Keep the display name
   `Basicrum - Real User Monitoring`; wp.org treats display name and slug
   separately, and the display name stays editable after approval.
