# Basicrum Privacy Policy Preparation Checklist

Use this checklist to prepare the public Privacy Policy for `basicrum.com` and
the hosted Basicrum service. Complete the sections in order. Write `unknown`
when an answer is not available yet instead of guessing.

This is a compliance-readiness worksheet, not legal advice. Decisions about
controller roles, legal bases, cookie requirements, international transfers,
and German business status should be confirmed by qualified counsel.

## Keep private information out of Git

- [ ] Do not enter a home address, private phone number, API key, password,
  customer identifier, contract, or security-sensitive infrastructure detail
  in this public repository.
- [ ] Use placeholders such as `[PUBLIC SERVICE ADDRESS]` in this file.
- [ ] Keep the complete vendor and contract records in a private location.
- [ ] Add the real public contact details directly to the final website page.

## Status labels

Use these labels beside unresolved decisions:

- `PASS` - the statement is supported by code, runtime evidence, and current
  documentation.
- `FAIL` - actual behavior and the proposed disclosure do not agree.
- `NEEDS LEGAL DECISION` - the answer depends on law, contracts, roles,
  jurisdiction, or a business decision.
- `NOT APPLICABLE` - evidence shows that the item does not apply.

## Step 1: Identify the controller

- [ ] Confirm the controller's full legal name and spelling.
  - Public value: `[FULL LEGAL NAME]`
- [ ] Confirm that this person alone decides why and how Basicrum processes
  personal data.
  - Answer: `[YES / NO / UNKNOWN]`
- [ ] Record whether another contributor jointly decides collection,
  retention, vendors, product purposes, or customer terms.
  - Answer: `[TO COMPLETE]`
- [ ] If another person jointly makes those decisions, stop and assess joint
  controllership under GDPR Article 26.
  - Status: `NEEDS LEGAL DECISION`
- [ ] Confirm the German city and federal state from which Basicrum is
  operated. Do not put the street address here.
  - City/state: `[CITY, FEDERAL STATE]`
- [ ] Choose a serviceable postal address for the final Privacy Policy and
  Impressum.
  - Public placeholder: `[PUBLIC SERVICE ADDRESS]`
- [ ] Create or confirm the privacy contact email.
  - Proposed value: `privacy@basicrum.com`
- [ ] Identify the competent German data-protection supervisory authority.
  - Authority: `[TO COMPLETE AFTER FEDERAL STATE IS KNOWN]`

Suggested opening, only if one person is the sole controller:

> Basicrum is a project operated by `[FULL LEGAL NAME]`. For the processing
> described in this Privacy Policy, the controller is `[FULL LEGAL NAME]`,
> `[PUBLIC SERVICE ADDRESS]`, Germany. Privacy questions and requests can be
> sent to `privacy@basicrum.com`.

## Step 2: Define what the policy covers

- [ ] Confirm that the policy covers the public `basicrum.com` website.
- [ ] Confirm that it covers contact and private-beta requests.
- [ ] Confirm that it covers hosted Basicrum customer accounts.
- [ ] Confirm that it covers the hosted collector and dashboard.
- [ ] Decide whether `demo.playground.basicrum.com` is covered by the same
  policy or needs a separate notice.
  - Answer: `[TO COMPLETE]`
- [ ] State that self-hosted Basicrum operators are responsible for their own
  processing and privacy notices.
- [ ] List any other Basicrum domains or applications in scope.
  - Domains/apps: `[TO COMPLETE]`

## Step 3: Inventory the public website

### Hosting and request logs

- [ ] Name the website hosting provider privately and record its country.
  - Provider/country: `[TO COMPLETE]`
- [ ] Record whether a CDN, reverse proxy, DNS proxy, or DDoS provider receives
  visitor requests.
  - Provider/country: `[TO COMPLETE]`
- [ ] Confirm which request-log fields are stored: IP address, timestamp,
  requested URL, referrer, user agent, response status, and error details.
  - Fields: `[TO COMPLETE]`
- [ ] Set and verify the request-log retention period.
  - Retention: `[TO COMPLETE]`
- [ ] Document the security and service-delivery purpose.
- [ ] Select and legally review the applicable GDPR legal basis.
  - Status: `NEEDS LEGAL DECISION`

### Contact and private-beta requests

- [ ] Describe what happens when someone submits an email address or contact
  request on `basicrum.com`.
- [ ] List every collected field.
  - Fields: `[TO COMPLETE]`
- [ ] Name the email, form, CRM, or newsletter provider privately.
  - Provider/country: `[TO COMPLETE]`
- [ ] Confirm whether double opt-in is used for marketing email.
  - Answer: `[YES / NO / NOT APPLICABLE]`
- [ ] Separate service or beta-request messages from marketing subscriptions.
- [ ] Set retention for accepted, rejected, abandoned, and withdrawn requests.
  - Retention: `[TO COMPLETE]`
- [ ] Explain how consent can be withdrawn where consent is the legal basis.

### Website cookies and third-party content

- [ ] Run a cookie and browser-storage inventory on the public website.
- [ ] List each cookie or storage key, provider, purpose, lifetime, domain,
  path, Secure flag, and SameSite value.
- [ ] Inventory analytics, error monitoring, support chat, embedded media,
  fonts, maps, CAPTCHA, and social-media embeds.
- [ ] Confirm which resources contact third parties before consent.
- [ ] Implement a consent mechanism where legally required.
  - Status: `NEEDS LEGAL DECISION`

## Step 4: Inventory Basicrum customer accounts

- [ ] List the data collected for beta access and account creation.
  - Possible categories to confirm: name, email, password or identity-provider
    identifier, organization, website, Brum Site ID, and account status.
- [ ] Confirm whether passwords are stored directly or delegated to an
  identity provider.
- [ ] Describe the purpose of each account-data field.
- [ ] Identify which fields are required and what happens if they are not
  provided.
- [ ] Set account-data retention during the beta and after account closure.
  - Retention: `[TO COMPLETE]`
- [ ] Document support messages and their retention.
- [ ] Document billing and tax records if payment is introduced.
  - Current status: `[FREE BETA / PAID / NOT DECIDED]`
- [ ] Select and review the legal basis for account, support, billing, and
  security processing.
  - Status: `NEEDS LEGAL DECISION`

## Step 5: Inventory hosted RUM telemetry

The WordPress plugin audit establishes that the browser may transmit the
following categories. Confirm what the hosted collector receives, stores,
indexes, aggregates, and deletes. See `docs/audits/evidence.md` for the runtime
evidence.

- [ ] Page, navigation, referrer, and resource URLs.
- [ ] Complete query strings when customer-side redaction is disabled.
- [ ] Timing data, page types, Core Web Vitals, and resource measurements.
- [ ] Interaction counts and timestamps.
- [ ] Pointer coordinates and interacted-element CSS selectors where present.
- [ ] Screen, browser, device, CPU, memory, network, DOM, and browser-storage
  size information.
- [ ] Brum Site ID.
- [ ] Random `RT` session identifier linking page views.
- [ ] IP address and user agent observed by the HTTP collector.
- [ ] Confirm that keystroke values and browser-storage contents are not
  collected.
- [ ] Confirm that battery data and high-entropy client hints are not
  collected by the current WordPress integration.
- [ ] Document any additional backend-derived fields, geolocation, user agent
  parsing, fingerprinting, enrichment, or identifiers.
  - Additional fields: `[TO COMPLETE]`
- [ ] Determine which fields are necessary for the documented RUM purpose and
  disable unnecessary collection.
  - Status: `NEEDS LEGAL DECISION`

## Step 6: Define customer and Basicrum roles

- [ ] Confirm whether the customer determines the purpose of monitoring its
  visitors and Basicrum processes the telemetry only on the customer's
  instructions.
- [ ] If yes, document the customer as controller and Basicrum as processor for
  hosted RUM telemetry.
- [ ] Prepare an Article 28 Data Processing Agreement for hosted customers.
- [ ] List every permitted processing instruction and Basicrum's security,
  deletion, assistance, audit, and subprocessor commitments.
- [ ] Determine whether Basicrum uses customer telemetry for its own product
  analytics, research, model training, benchmarking, or unrelated purposes.
  - Answer: `[TO COMPLETE]`
- [ ] If Basicrum determines any additional purpose, reassess whether it is a
  controller for that processing.
  - Status: `NEEDS LEGAL DECISION`

## Step 7: Document the `RT` cookie and consent

- [ ] Disclose that monitored customer sites may set a first-party `RT`
  cookie.
- [ ] Confirm the audited attributes: path `/`, `SameSite=Strict`, Secure only
  on HTTPS, rolling seven-day expiry, and a 30-minute session window.
- [ ] Explain that the cookie contains a random session identifier linking
  monitored page views.
- [ ] Explain that opt-out removes `RT` and any legacy `BA` cookie.
- [ ] State that Basicrum's WordPress plugin supports:
  - Monitoring without waiting for consent.
  - Requiring an external consent decision before monitoring.
- [ ] State that the website operator, not the plugin, selects the legal basis
  and configures consent where required.
- [ ] Assess the ePrivacy classification of the `RT` cookie and the conditions
  for setting it without prior consent.
  - Status: `NEEDS LEGAL DECISION`
- [ ] Document that withdrawing consent stops future collection but cannot
  retract beacons already sent.

## Step 8: Set retention and deletion rules

Do not use only "as long as necessary." Record a period or objective criterion
for every category.

- [ ] Website request logs: `[PERIOD]`
- [ ] Contact messages: `[PERIOD]`
- [ ] Marketing subscriptions: `[UNTIL WITHDRAWAL PLUS SUPPRESSION RECORD]`
- [ ] Rejected beta requests: `[PERIOD]`
- [ ] Customer account data: `[PERIOD AFTER CLOSURE]`
- [ ] Raw RUM beacons: `[PERIOD]`
- [ ] Aggregated RUM metrics: `[PERIOD]`
- [ ] Collector IP/request logs: `[PERIOD]`
- [ ] Support history: `[PERIOD]`
- [ ] Backups: `[ROTATION AND FINAL DELETION PERIOD]`
- [ ] Security and abuse records: `[PERIOD]`
- [ ] Define the customer-initiated deletion procedure.
- [ ] Define how an individual visitor can be identified for access or
  deletion, or document why identification is not technically possible.
- [ ] Ensure deletion propagates to indexes, replicas, exports, and backups
  according to the stated schedule.

## Step 9: Record vendors, recipients, and transfers

Maintain the detailed register privately. Publish enough information for users
to understand where their data goes.

- [ ] Hosting and infrastructure providers.
- [ ] CDN, DNS, and security providers.
- [ ] Email and newsletter providers.
- [ ] Identity and authentication providers.
- [ ] Support and communication providers.
- [ ] Monitoring and error-reporting providers.
- [ ] Backup providers.
- [ ] Payment providers, if applicable.
- [ ] AI providers, if applicable.
- [ ] Record each provider's legal entity, purpose, processing country, data
  categories, retention, contract, and subprocessor status.
- [ ] Identify transfers outside the EU/EEA.
- [ ] Document adequacy decisions, Standard Contractual Clauses, supplementary
  measures, or another transfer mechanism where required.
  - Status: `NEEDS LEGAL DECISION`

## Step 10: Describe AI processing accurately

- [ ] Confirm whether AI features are currently active.
- [ ] Confirm whether an AI request is automatic or initiated by the customer.
- [ ] List exactly what is sent: raw beacons, URLs, selectors, aggregated
  metrics, or prepared summaries.
- [ ] Confirm whether the customer or Basicrum supplies the provider API key.
- [ ] Name supported providers and processing locations.
- [ ] Confirm provider retention and whether submitted data may be used for
  model training.
- [ ] Document how sensitive URL or selector data is removed before an AI
  request.
- [ ] Remove or qualify any public "No PII" or similar absolute claim that
  cannot be demonstrated for every processing path.

## Step 11: Prepare individual-rights procedures

- [ ] Publish the privacy-request contact email.
- [ ] Create an internal process for access, correction, deletion,
  restriction, portability, objection, and consent withdrawal requests.
- [ ] Define how identity is verified without collecting excessive additional
  data.
- [ ] Define who responds and how the one-month GDPR deadline is tracked.
- [ ] Explain when a customer must handle a monitored visitor's request and
  how Basicrum assists as processor.
- [ ] Name the competent supervisory authority and explain the right to lodge
  a complaint.
- [ ] Record whether automated decision-making or profiling with legal or
  similarly significant effects occurs.
  - Expected answer: `[YES / NO / UNKNOWN]`

## Step 12: Prepare security and governance records

- [ ] Document access controls and administrator roles.
- [ ] Document encryption in transit and at rest.
- [ ] Document secrets management, backups, patching, and vulnerability
  handling.
- [ ] Create a personal-data breach response process.
- [ ] Maintain a record of processing activities where required or useful.
- [ ] Assess whether a Data Protection Impact Assessment is required.
  - Status: `NEEDS LEGAL DECISION`
- [ ] Assess whether a Data Protection Officer is required. Do not appoint or
  claim one without a valid basis.
  - Status: `NEEDS LEGAL DECISION`

## Step 13: Draft the public Privacy Policy

- [ ] Title and effective date.
- [ ] Controller identity and contact details.
- [ ] Scope and definitions.
- [ ] Public website and server logs.
- [ ] Contact and private-beta requests.
- [ ] Customer accounts and support.
- [ ] Hosted RUM telemetry and customer/processor roles.
- [ ] Cookies, consent, and withdrawal limits.
- [ ] AI functionality.
- [ ] Purposes and legal bases by processing activity.
- [ ] Recipients and subprocessors.
- [ ] International transfers and safeguards.
- [ ] Retention and deletion by data category.
- [ ] Required and optional information and consequences of not providing it.
- [ ] Individual rights and complaint authority.
- [ ] Automated decision-making statement.
- [ ] Security summary.
- [ ] Policy-change process.
- [ ] Use clear, plain language and a layered structure.
- [ ] Ensure the policy describes actual behavior rather than aspirations.

## Step 14: Prepare the related legal surfaces

- [ ] Publish a separate German `Impressum` or Legal Notice containing the
  actual provider name, serviceable address, and direct electronic contact.
- [ ] Do not claim a company form, register entry, or registration number that
  does not exist.
- [ ] Confirm whether operating jointly has already created a German civil-law
  partnership (`GbR`).
  - Status: `NEEDS LEGAL DECISION`
- [ ] Prepare hosted-service Terms of Service.
- [ ] Prepare the hosted-service Data Processing Agreement.
- [ ] Prepare a current subprocessor list.
- [ ] Ensure contracts, policy, product behavior, and marketing claims agree.

## Step 15: Review and publish

- [ ] Have the controller-role, legal-basis, ePrivacy, transfer, retention,
  and German business-status decisions reviewed by qualified counsel.
- [ ] Compare the final policy against a captured website request, signup flow,
  account flow, representative RUM beacon, cookie inventory, AI request, and
  deletion test.
- [ ] Remove or correct conflicting marketing claims on `basicrum.com`.
- [ ] Link `Privacy Policy`, `Terms`, and `Impressum` from every website page.
- [ ] Link the hosted-service Privacy Policy and Terms from the WordPress.org
  plugin `readme.txt` External services section.
- [ ] Add the links near beta signup and account creation.
- [ ] Record the publication date and next review date.
- [ ] Review the policy whenever data fields, purposes, vendors, retention,
  countries, cookies, AI providers, or consent behavior change.

## Definition of done

- [ ] Every processing activity has a named purpose, data category, recipient,
  legal basis, retention rule, deletion path, and public disclosure.
- [ ] Controller and processor roles match contracts and actual decisions.
- [ ] Cookie and consent statements match tested runtime behavior.
- [ ] No absolute compliance or "no personal data" claim contradicts the
  observed data flow.
- [ ] Privacy Policy, Terms, Impressum, DPA, and subprocessor information are
  mutually consistent.
- [ ] The final policy has been reviewed for the jurisdictions and service
  model actually used.

## Primary references

Accessed 2026-07-21:

- [GDPR Articles 12-14, 26, and 28](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32016R0679)
- [ePrivacy Directive Article 5(3)](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX%3A32002L0058)
- [EDPB guidance for small businesses](https://www.edpb.europa.eu/sme/be-compliant/respect-individuals-rights_en)
- [EDPB Guidelines 05/2020 on consent](https://www.edpb.europa.eu/documents/guideline/guidelines-052020-on-consent-under-regulation-2016679_en)
- [German Digital Services Act, Section 5](https://www.gesetze-im-internet.de/ddg/__5.html)
- [German Civil Code, Section 705](https://www.gesetze-im-internet.de/bgb/__705.html)
- [WordPress Plugin Directory external-service guidance](https://developer.wordpress.org/plugins/wordpress-org/common-issues/)
