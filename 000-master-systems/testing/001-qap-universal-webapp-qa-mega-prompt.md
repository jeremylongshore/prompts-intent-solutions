---
name: universal-webapp-qa-mega-prompt
description: Complete end-to-end QA suite for any web app - preserve all tests, add missing ones, optimize, and produce auditable proof
model: opus
date: 2025-10-08
---

# UNIVERSAL WEB-APP QA MEGA PROMPT

**Keep all tests. Add missing ones. Optimize. Produce proof.**

---

## MISSION

Harden and execute a complete end-to-end QA suite for any web app. Do not remove tests. Fill gaps, reduce flake, and output auditable artifacts.

---

## INPUTS

- **Existing test plan and code** (paste-in content below)
- **Runtime context** auto-detected from repo: framework, host, CI, env files

---

## NON-NEGOTIABLES

- ✅ **Preserve every existing test**. Only add or refactor.
- ✅ **Idempotent runs**. No destructive ops. Default to staging URL.
- ✅ **Gate optional suites** behind capability checks.
- ✅ **After each phase**, stop and print a short report.

---

## ADAPTERS (auto-select, create if missing)

### Submission Verification
- Netlify
- Vercel
- Cloudflare
- Generic REST
- Custom DB logger

### Email
- Mailosaur
- Mailtrap
- Gmail API
- SES/SendGrid
- "NEEDS_INBOX" flag if none

### Storage/Logs
- Cloud provider logs
- Server logs
- DB row
- Webhook capture

### Auth
- Public
- Basic
- OAuth/OIDC
- CSRF token helper

---

## ARTIFACT RULES

Write all outputs under `tests/artifacts/<YYYY-MM-DD_HHMM>/`:

```
tests/artifacts/<YYYY-MM-DD_HHMM>/
├── reports/              # HTML, JSON, JUnit
├── screenshots/          # Visual evidence
├── videos/               # Test recordings
├── traces/               # Playwright traces
├── lighthouse/           # Performance reports
├── accessibility/        # a11y audit results
├── security/             # Security scan results
├── visual/               # Visual regression diffs
├── load/                 # Load test results
├── evidence/             # Submission IDs, email headers, API payloads
├── SUMMARY.md            # Executive summary
└── TASKS.md              # If Taskwarrior absent
```

---

## ENVIRONMENT NORMALIZATION

Create `.env.test.local` if missing with placeholders:

```bash
APP_URL=
APP_URL_STAGING=
NETLIFY_SITE_ID=
NETLIFY_AUTH_TOKEN=
EMAIL_ADAPTER=(mailosaur|mailtrap|gmail|none)
MAILOSAUR_API_KEY=
MAILOSAUR_SERVER_ID=
CI=false
```

**Never commit secrets.**

---

## PHASE 0 — DETECT & PLAN

1. **Detect framework** (React/Next/Svelte/Vue/Nuxt/Static)
2. **Detect host** (Netlify/Vercel/CF/AWS)
3. **Detect router**, build command, available test dirs
4. **Pick adapters**
5. **Print Plan Summary** with selected adapters and skipped suites with reasons
6. **Wait for approval**

---

## PHASE 1 — STRUCTURE & SCRIPTS

### Keep current layout. Add only if missing:

```
tests/
├── playwright/
├── cypress/
├── selenium/
├── testcafe/
├── nightwatch/
├── helpers/
├── adapters/
├── scripts/
└── artifacts/.gitkeep
```

### Add capability-guarded scripts (do not break existing ones):

```json
{
  "scripts": {
    "test:core": "Playwright core E2E",
    "test:accessibility": "axe/pa11y",
    "test:performance": "Lighthouse",
    "test:visual": "BackstopJS",
    "test:security": "headers, XSS/SQLi probes",
    "test:load": "Artillery/k6 if present",
    "test:ci": "minimal deterministic matrix",
    "test:complete": "runs everything available, gates missing tools"
  }
}
```

---

## PHASE 2 — DEPENDENCIES (no bloat)

- ✅ Install **only what matched** by present test dirs or adapters
- ✅ **Pin minor versions** if unpinned
- ✅ **Cache in CI**
- ✅ Replace deprecated `faker` with `@faker-js/faker` if used

---

## PHASE 3 — TEST COVERAGE MATRIX (add missing suites)

### A. Manual-equivalent E2E (automated)

- ✅ Form happy path with redirect, field echo, and submission verification via adapter
- ✅ Dashboard/API verification of stored submission
- ✅ Email notification receipt + content check (if inbox available)
- ✅ Error handling path, network fail, offline/PWA submit messaging
- ✅ Rate-limit/spam path, honeypot/reCAPTCHA presence check

### B. Validation & Edge Cases

- ✅ Empty, partial, invalid formats, boundary lengths, unicode, RTL, emojis
- ✅ Special chars and XSS payloads. Confirm no alert/HTML injection
- ✅ Rapid multi-submit sequencing and idempotency

### C. Cross-browser & Devices

- ✅ Chromium, Firefox, WebKit
- ✅ Mobile viewports (iPhone/Android), tablet, common desktops
- ✅ Private mode and ad-block run

### D. Accessibility (WCAG 2.1 AA)

- ✅ Keyboard only flow. Logical tab/focus order. Focus visible
- ✅ Labels, roles, names. Required announcements. Error/success announcements
- ✅ Color contrast checks. Zoom to 200% without horizontal scroll
- ✅ ARIA live regions for status

### E. Performance

- ✅ Lighthouse desktop+mobile. Assert thresholds:
  - Performance ≥ 70
  - Accessibility ≥ 90
  - Best-Practices ≥ 90
  - SEO ≥ 90
- ✅ Web-Vitals sampling where possible

### F. Visual Regression

- ✅ Key routes and form states
- ✅ Reference → test → approve flow
- ✅ Mismatch threshold ≤ 0.1%

### G. Security Sanity

- ✅ HTTPS redirect, HSTS, X-Frame-Options, X-Content-Type-Options
- ✅ CSP presence, Referrer-Policy
- ✅ Basic XSS/SQLi probe responses must not leak stack traces

### H. Networking & Observability

- ✅ Console free of errors
- ✅ Network tab POST status 2xx/3xx, timing budget logged
- ✅ Server/app logs captured where supported

### I. Load/Soak (optional, gated)

- ✅ 1–5 rps warmup, 10 rps sustain, spike 20 rps
- ✅ Track p95 latency and error rate

### J. Internationalization (add if i18n present)

- ✅ Locale switch, date/number formats, dir=rtl

### K. Cookies/Storage/Auth (if app uses auth)

- ✅ CSRF token presence and rotation
- ✅ SameSite, Secure flags on cookies

---

## PHASE 4 — FLAKE REDUCTION

- ✅ Add retries **only around external flakiness**
- ✅ Deterministic data via **seeded faker**
- ✅ Network idle waits replaced with **explicit route waits**
- ✅ Quarantine tag for known infra issues, **never skip silently**

---

## PHASE 5 — EVIDENCE PACK

### Save:
- ✅ Screenshots pre/post submit, success page
- ✅ Console dump
- ✅ Network HAR
- ✅ Email raw source
- ✅ Webhook payloads
- ✅ Submission IDs
- ✅ API responses
- ✅ Lighthouse HTML
- ✅ axe JSON
- ✅ Backstop HTML
- ✅ JUnit

### Generate `SUMMARY.md` with:
- App URL tested
- Adapter used
- Submission IDs list
- Violations table
- Thresholds vs scores
- Next actions

---

## PHASE 6 — EXIT CRITERIA

- ✅ All core E2E pass
- ✅ WCAG 2.1 AA violations = 0 or documented waivers with remediation tasks
- ✅ Lighthouse thresholds met or ticketed
- ✅ Security headers present or ticketed
- ✅ Visual diffs approved
- ✅ Evidence pack complete

---

## REQUIRED ADDITIONS (create if missing)

### Adapters (`tests/adapters/`)

```javascript
// submission-verifier.netlify.js
// submission-verifier.generic.js
// email.mailosaur.js
// email.mailtrap.js
// email.gmail.js
```

### Helpers (`tests/helpers/`)

```javascript
// data-generator.js (seeded faker)
// screenshots.js (timestamped)
// api.js (generic REST + provider helpers)
```

### Scripts (`tests/scripts/`)

```bash
# assert-security-headers.js
# collect-artifacts.js
# network-record.js
```

**Each file must be framework-agnostic and read from `.env.test*`.**

---

## CORE ASSERTIONS TO INCLUDE (merge with existing)

### Form Attributes
- ✅ method, action or platform flags
- ✅ hidden form-name if relevant

### Submission Integrity
- ✅ Dashboard/API shows exact field echo
- ✅ Correct timestamp
- ✅ Unique ID

### Email Content
- ✅ Subject
- ✅ Fields
- ✅ Submission ID
- ✅ Valid links

### A11y
- ✅ No axe violations of critical/serious
- ✅ Tab order equals DOM/logical order
- ✅ Live region announces submit result

### Performance
- ✅ TTFB and LCP within budget
- ✅ Page load < 3s on default device in clean network

### Security Headers
- ✅ HSTS, XFO, XCTO, CSP, Referrer-Policy present

### Visual
- ✅ 0.1% mismatch threshold or approved baseline change

---

## REPORTING FORMAT (print after each phase)

```
PHASE <n> REPORT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Decisions:
  - [List key decisions made]

Added/Refactored:
  - [Files created or modified]

Skipped (and why):
  - [Suites not run and justification]

New Risks:
  - [Identified risks or blockers]

Next:
  - [What happens in next phase]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## FINAL OUTPUT

1. **Updated tests and helpers**, no deletions of existing suites
2. **`tests/artifacts/<stamp>/SUMMARY.md`** with links to every artifact
3. **Exit code 0** only if exit criteria met
4. **Else exit 1** and list exact failing checks with `file:line` hints

---

## EXAMPLE SUMMARY.md

```markdown
# QA Test Suite Summary

**Date:** 2025-10-08 14:30:00
**App URL:** https://staging.example.com
**Duration:** 12m 34s

## Adapter Configuration
- **Submission Verifier:** Netlify API
- **Email:** Mailosaur
- **Auth:** None (public form)

## Test Results

### E2E Tests: ✅ PASS (15/15)
- Form submission happy path ✅
- Field validation ✅
- Email notification ✅
- Error handling ✅
- Rate limiting ✅

### Accessibility: ✅ PASS (0 violations)
- WCAG 2.1 AA compliance ✅
- Keyboard navigation ✅
- Screen reader announcements ✅

### Performance: ✅ PASS
| Metric | Desktop | Mobile | Threshold |
|--------|---------|--------|-----------|
| Performance | 92 | 78 | ≥70 |
| Accessibility | 100 | 100 | ≥90 |
| Best Practices | 95 | 95 | ≥90 |
| SEO | 100 | 100 | ≥90 |

### Security: ✅ PASS
- HTTPS redirect ✅
- HSTS header ✅
- X-Frame-Options ✅
- Content-Security-Policy ✅
- XSS protection ✅

### Visual Regression: ✅ PASS
- 0.08% pixel difference (threshold: 0.1%)

## Evidence Artifacts

- [Screenshots](./screenshots/)
- [Lighthouse Reports](./lighthouse/)
- [Accessibility Audit](./accessibility/axe-report.json)
- [Security Scan](./security/headers.json)
- [Visual Regression](./visual/backstop_report.html)
- [Network HAR](./evidence/network.har)
- [Submission IDs](./evidence/submissions.json)

## Submission Verification

**Total Submissions:** 15
**Verified:** 15/15 ✅

| Test Case | Submission ID | Dashboard Match | Email Sent |
|-----------|---------------|-----------------|------------|
| Happy path | sub_abc123 | ✅ | ✅ |
| Unicode data | sub_def456 | ✅ | ✅ |
| Special chars | sub_ghi789 | ✅ | ✅ |

## Next Actions

✅ All exit criteria met - ready for production deployment

## Full Test Log

See [test-output.log](./reports/test-output.log)
```

---

## USAGE INSTRUCTIONS

### Paste Existing Plan/Code Below

```
<PASTE THE ENTIRE TEST SUITE AND CONFIG YOU GAVE ME>
```

*(Yes, it's a lot. So is production. Let's make your bugs afraid of the dark.)*

---

## EXAMPLE ADAPTER IMPLEMENTATION

### `tests/adapters/submission-verifier.netlify.js`

```javascript
const axios = require('axios');

class NetlifySubmissionVerifier {
  constructor() {
    this.siteId = process.env.NETLIFY_SITE_ID;
    this.authToken = process.env.NETLIFY_AUTH_TOKEN;
    this.baseUrl = `https://api.netlify.com/api/v1/sites/${this.siteId}`;
  }

  async verifySubmission(submissionId, expectedData) {
    const response = await axios.get(
      `${this.baseUrl}/submissions/${submissionId}`,
      {
        headers: { Authorization: `Bearer ${this.authToken}` }
      }
    );

    const submission = response.data;
    const matches = Object.keys(expectedData).every(
      key => submission.data[key] === expectedData[key]
    );

    return {
      found: true,
      matches,
      submissionId: submission.id,
      timestamp: submission.created_at,
      data: submission.data
    };
  }

  async getRecentSubmissions(limit = 10) {
    const response = await axios.get(
      `${this.baseUrl}/submissions?per_page=${limit}`,
      {
        headers: { Authorization: `Bearer ${this.authToken}` }
      }
    );
    return response.data;
  }
}

module.exports = NetlifySubmissionVerifier;
```

### `tests/helpers/data-generator.js`

```javascript
const { faker } = require('@faker-js/faker');

// Seed for deterministic data
faker.seed(12345);

function generateFormData() {
  return {
    name: faker.person.fullName(),
    email: faker.internet.email(),
    phone: faker.phone.number(),
    message: faker.lorem.paragraph(),
    timestamp: new Date().toISOString()
  };
}

function generateEdgeCaseData() {
  return [
    { name: '', email: '', message: '' }, // Empty
    { name: 'A', email: 'a@b.c', message: 'x' }, // Minimal
    { name: 'a'.repeat(255), email: 'test@example.com', message: 'x'.repeat(5000) }, // Max length
    { name: '测试用户', email: 'test@例え.jp', message: 'مرحبا' }, // Unicode
    { name: '<script>alert(1)</script>', email: 'test@test.com', message: 'XSS' }, // XSS
    { name: "O'Brien", email: "test+tag@example.com", message: "Quote's test" } // Special chars
  ];
}

module.exports = {
  generateFormData,
  generateEdgeCaseData
};
```

---

**Master Location:** `~/projects/prompts-intent-solutions/000-master-systems/testing/001-qap-universal-webapp-qa-mega-prompt.md`

**Related Documents:**
- Release workflow: `~/projects/prompts-intent-solutions/000-master-systems/github/001-rel-master-repo-release.md`

---

*UNIVERSAL WEB-APP QA – Complete End-to-End Testing Framework*
