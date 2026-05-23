# Site Audit Finding Taxonomy
<!--
  @file:        templates/site-audit/finding-taxonomy.md
  @description: Reusable finding categories, severity levels, and evidence requirements for site audits
  @updated:     2026-05-24
  @version:     1.1
-->

## Finding Categories

| Category | Use When |
|---|---|
| Technical frontend health | Console/runtime errors, failed public requests, broken assets, hydration issues, broken routes/links, mixed content, compatibility signals. |
| UX/usability | Navigation, user path clarity, state visibility, control/freedom, consistency, error prevention, primary task completion. |
| Accessibility | Headings, landmarks, labels, alt text, keyboard/focus, contrast, reflow, status messages, control semantics. |
| Responsive/mobile | Mobile widths, touch targets, sticky overlays, reflow, mobile menus, modals, viewport-specific layout failures. |
| Forms/tools | Labels, hints, validation, states, consent/privacy, non-submit behavior, submit safety boundaries. |
| Marketing/sales effectiveness | Value proposition, offer clarity, differentiation, pricing/tariff clarity, sales path, CTA relevance, objection handling, proof, credibility, and conversion trust. |
| Target-audience usefulness | Audience clarity, user pain/job-to-be-done fit, service/tool usefulness, decision support, examples, and mismatch between claimed value and actual page/tool behavior. |
| SEO | Titles, descriptions, headings, canonicals, crawlability, links, structured data, useful people-first public content. |
| AEO/GEO/AI-friendly content | Answerable sections, entity clarity, reliable sourcing, visible-content/schema alignment, useful summaries/FAQs. |
| AI/agentic-commerce readiness | Assistant readability, service/action clarity, stable deep links, structured offers, pricing/limitations/policy parseability, recommendation safety, and user confirmation points. |
| Copy/trust/legal-risk wording | Grammar, clarity, claims, guarantees, pricing/risk wording, disclaimers, company/contact/support signals. |
| Design/visual consistency | Typography, spacing, alignment, state colors, component consistency, visual hierarchy, overlap, clipping, broken media. |
| Analytics/conversion | CTA visibility, funnel clarity, public instrumentation signals, friction, dead ends, trust blockers. |
| Public UI security/privacy | Exposed secrets, PII, debug output, private endpoints, auth/payment/admin boundaries, mixed content, unsafe errors. |

## Severity Levels

| Severity | Definition | Typical Examples |
|---|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. | Homepage fails to load; public API key exposed; form submits real data unexpectedly; payment/admin route exposed. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. | Keyboard trap; mobile layout unusable; primary CTA missing; misleading claim; structured data contradicts visible content. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. | Weak headings; inconsistent labels; missing loading/error state; several broken secondary links. |
| Low | Local polish issue or minor inconsistency with limited user impact. | One typo in non-critical copy; minor spacing mismatch; secondary icon alignment issue. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. | Optional schema opportunity; analytics not visible from public scope; useful future mobile check. |

Escalate one level when the issue affects vulnerable users, mobile users, new users, legal/financial/medical decisions, data submission, or high-traffic conversion paths.

## Evidence Requirements

Every finding must include:

- Finding ID.
- Category.
- Severity.
- Location: route, source file, selector, section, viewport, or artifact.
- Evidence: observed fact, source line, command output, sanitized browser summary, approved screenshot reference, or supplied log excerpt.
- Impact: who or what is affected and how.
- Recommendation: concrete next action.

Label inferences clearly:

- `Observed:` for direct evidence.
- `Inferred risk:` for a risk that follows from evidence but was not directly reproduced.
- `Unknown:` for a missing fact that needs approved follow-up.

## Common Examples

| Pattern | Category | Default Severity |
|---|---|---|
| Public page returns 500 | Technical frontend health | Critical or High |
| Primary CTA hidden below first viewport on mobile | UX/usability, responsive/mobile, conversion | High |
| Form input has no accessible label | Accessibility, forms/tools | High or Medium |
| Structured data claims content not visible on page | SEO, AEO/GEO | High |
| One secondary footer link returns 404 | Technical frontend health, SEO | Medium or Low |
| Primary service page does not state who the offer is for | Target-audience usefulness, marketing/sales effectiveness | High or Medium |
| Pricing or plan limitations are unclear on the main sales path | Marketing/sales effectiveness, AI/agentic-commerce readiness | High or Medium |
| Service action exists only in a modal with no stable URL or explanation | AI/agentic-commerce readiness, UX/usability | Medium |
| Company identity or contact signal missing on a trust-sensitive page | Copy/trust/legal-risk wording | High or Medium |
| Minor inconsistent card spacing | Design/visual consistency | Low |

## Avoiding Duplicates

- Group repeated instances under one finding when the root cause and recommendation are the same.
- Split findings when severity, user path, route, root cause, or fix owner differs.
- Link related findings instead of copying the same evidence into multiple rows.
- Do not create separate marketing, target-audience, SEO, AEO/GEO, AI/agentic-readiness, and copy findings for the same content problem unless each has distinct evidence and impact.
- Keep regression findings tied to the original finding ID.

## Escalate To Specialist Review

Escalate when:

- legal, medical, financial, regulatory, or safety claims require domain accuracy;
- accessibility impact needs WCAG interpretation beyond obvious automated signals;
- security/privacy evidence suggests secrets, PII, auth/session material, payment data, or private endpoints;
- performance requires profiling beyond high-level audit signals;
- SEO/AEO/GEO changes risk manipulative tactics, misleading schema, or content quality harm;
- AI/agentic-commerce recommendations affect legal, financial, medical, safety, payment, account, or other state-changing decisions;
- visual design requires brand-system judgment not available from the current scope.
