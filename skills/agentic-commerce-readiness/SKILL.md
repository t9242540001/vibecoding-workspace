---
name: agentic-commerce-readiness
description: Technology- and region-agnostic, prioritized (P0→P2) checklist for making product/catalog pages legible to AI buying agents — the two-layer product model (computable agent-readable attributes with units + consumer-readable narrative), attribute completeness ("Golden Record"), price/availability in static server HTML (not JS), product-feed hygiene, data consistency across page↔feed↔sources, stock/price freshness, review trust signals, the discovery-vs-checkout boundary, and a dated map of agent protocols (UCP, ACP, MCP, AP2, MPP) with a regional fork. Use whenever a product or catalog page is created or revised, a commerce project is prepared for AI agents, a product feed is configured or audited, or buying-agent visibility is in question. Frames discovery as mature and checkout as immature. Mandatory here. Do NOT use for non-commerce pages, the technical wrapper (use page-technical-seo), schema mechanics (use structured-data-discipline), page text (use geo-content-discipline), or internal documentation.
---

# Agentic Commerce Readiness
<!--
  @file:        skills/agentic-commerce-readiness/SKILL.md
  @description: Technology/region-agnostic, prioritized (P0→P2) checklist for making product/catalog
                pages legible to AI buying agents. Two-layer product model, attribute completeness,
                static-HTML price/availability, feed hygiene, cross-source consistency, freshness,
                discovery-vs-checkout boundary, dated protocol map. Part of the "SEO + GEO optimization" series.
  @version:     1.0
  @updated:     2026-06-12
  @review-note: Section 6 (protocol map) is a DATED snapshot — protocols change every few months.
                Re-verify the named protocols, percentages, and adoption claims before relying on them.
-->

---

## 1. Philosophy

AI buying agents are becoming the first filter in product discovery: a user asks an agent for "X under Y with feature Z", and the agent scores every candidate it can read by how completely its attributes match the constraints — **before** the user ever sees a ranked list. An agent cannot see photography, lifestyle imagery, or persuasive copy. **It reads structured, machine-parseable data.** A product whose data is incomplete or unreadable is on the "invisible shelf": it exists, but no agent can recommend it. Attribute completeness, not product quality, often decides whether you are the first recommendation or the eighth.

This skill makes product and catalog pages — and the feed behind them — **legible to agents**, for an international company across different projects, regions, and stacks. It is therefore **technology- and region-agnostic**: every item is an outcome (WHAT), and where the right action depends on platform or region, it forks ("if the AI surface ingests a feed → …; if it queries an endpoint → …") rather than naming one vendor as the answer.

**Frame the maturity honestly.** Two halves of agentic commerce are at very different stages:
- **Discovery is real and fact-based now** — agents are surfacing and comparing products today, driven mostly by **pre-submitted structured feeds and on-page data**. This is where the value and the work are.
- **Checkout is immature and contested** — flagship autonomous-checkout efforts have been cut back, merchant ROI is unproven, and competing protocols carry different costs and regional coverage. Do **not** rush to hand the transaction to an agent.

So the strategic default is: **win discovery, keep checkout with the brand.** Handing the front (product discovery) to agents earns organic visibility; handing your full data and the transaction to a third party can commoditize you into a pure price/speed race. Be the most legible source; keep the relationship and the sale.

**Two operating principles:**
1. **Outcome over mechanism.** Verified by *result achieved* (an agent can read price without JS; the feed validates), not by *which protocol or plugin you installed*.
2. **Done means validated, with evidence.** "JS-disabled load shows price and stock", "feed validation report = 0 errors", "page price == feed price" — each item carries evidence. And **progressive legibility**: do not wait for a perfect data environment; raise machine-readability every iteration.

Boundaries: technical wrapper → `page-technical-seo`. Schema *mechanics* (Product/Offer JSON-LD shape, validity, parity) → `structured-data-discipline`; this skill owns the *agent-consistency and feed* half. Page words → `geo-content-discipline`. This skill applies only to commerce (product/catalog) surfaces.

---

## 2. Scope

### In scope
The two-layer product model (agent-readable computable attributes + consumer-readable narrative); attribute completeness and value standardization (the "Golden Record"); price and availability present in static server-returned HTML; product-feed hygiene (identifiers, required attributes, error-free); data consistency across page ↔ feed ↔ other sources; freshness of stock/price; review trust signals (volume, recency, specificity); the discovery-vs-checkout boundary; a dated map of agent protocols (UCP / ACP / MCP / AP2 / MPP) with a regional fork; progressive-legibility sequencing.

### Out of scope
- The **technical wrapper** (title/meta/canonical/indexability/CWV) → `page-technical-seo`
- **Schema validity/parity/shape** (Product, Offer, AggregateRating JSON-LD) → `structured-data-discipline` (this skill references it but does not redefine it)
- The **page's prose/content** → `geo-content-discipline`
- **Non-commerce pages** (article/news/service/landing without a product)
- Internal docs, ADRs, prompts, code comments

If unsure: "Is this about a product/catalog surface being readable and trustworthy to a *buying agent*?" If yes → here. If it is the wrapper, the schema shape, or the prose → the owning skill.

---

## 3. Activation Triggers

1. **A product or catalog page is created or revised.**
2. **A catalog/commerce project is prepared for AI agents** — "make our inventory agent-ready".
3. **A product feed is configured, migrated, or audited.**
4. **Buying-agent visibility is in question** — "do shopping agents surface our products?", products missing from AI shopping answers.
5. **The orchestrator delegates the agent-readiness layer** for a commerce page.

### Not a trigger
- Non-commerce page work (→ the relevant page skill)
- Wrapper-only changes (→ `page-technical-seo`)
- Schema-shape-only changes (→ `structured-data-discipline`)
- Prose-only changes (→ `geo-content-discipline`)
- Internal documentation

---

## 4. How to read the checklist

Each item: **Requirement (WHAT)** — the outcome; **Fork** *(only where present)* — `if <platform/region condition> → … / if <other> → …`; **Verify (evidence)** — an observable check with evidence. Default checks are universal: **disable JavaScript and load the page** (the fastest test of what an agent can read), **the feed platform's validation/diagnostics report**, a **page↔feed field diff**, and **prompting a real shopping agent** with the product's target constraints to see if it surfaces you.

**Priority tags:**
- **P0 — invisibility or false-data blocker.** If wrong, the product is unreadable to agents (price/stock behind JS, feed errors) or feeds them false facts (stale stock, page≠feed) → excluded or flagged unreliable. Fix first.
- **P1 — strong legibility/trust signal.** Attribute completeness, two-layer data, consistency, reviews — materially move agent confidence scores.
- **P2 — forward-looking / protocol posture.** Protocol adoption decisions, advanced endpoints — real but stage-dependent and often premature; pursue deliberately, not reflexively.

> **Project-context rule (anti-"Schema F").** This is a baseline for an international, multi-project company — not a mandate to adopt every protocol everywhere. Protocol choices are **region- and platform-dependent** and several are immature; adopt them only where the target market and AI surface actually support them, and record what you deliberately defer. Never wire up checkout protocols reflexively because the list names them. Discovery legibility (Blocks A–C) applies broadly; protocol posture (Block D) is selective by design.

---

## 5. The checklist — discovery legibility (the mature, do-now layer)

### Block A — Machine-readability of the core facts

**A1. Price and availability are present in the static, server-returned HTML.** — **P0**
Requirement: price, currency, and stock/availability are in the raw HTML the server returns, readable without executing JavaScript. Most agents and AI shopping surfaces read raw HTML (and feeds), not JS-rendered DOM.
Fork: **if these values are injected client-side** → move them to server-rendered output (SSR/SSG/ISR) or expose them via the feed/endpoint the target surface reads.
Verify: disable JavaScript and load the page → price, currency, availability all visible. Evidence: the JS-disabled render showing the three values.
Why P0: behind JS, the product is invisible to the agent regardless of how good the page is.

**A2. The product carries a complete, standardized attribute set (the "Golden Record").** — **P1**
Requirement: the attributes agents filter on are present, complete, and use standardized, comparable values with units — category, brand, identifiers, key specs, dimensions, materials, compatibility, condition, use case, key differentiator — defined as required fields at the item/SKU level via a template, not ad hoc. Completeness matters more than speed: partial data often means zero visibility, because constraint-matching drops items missing a queried attribute.
Fork: the exact attribute list is category-specific (a car's attributes ≠ a shoe's); define the required set per catalog.
Verify: check the product against its category's required-attribute template → all present, standardized, with units. Evidence: the completeness check (required vs present).

### Block B — Two-layer product data

**B1. Each product exposes both an agent-readable and a consumer-readable layer of the same facts.** — **P1**
Requirement:
- **Agent-readable layer** — attributes as *computable* values with units, so an agent can evaluate a constraint directly (e.g. `year: 2020`, `mileage: 80000 km`, `engine: 1998 cc`, `drivetrain: AWD`), not buried in prose. This lets an agent answer "mileage ≤ 100000 AND year ≥ 2018" without inference.
- **Consumer-readable layer** — the same facts in human language explaining *why they matter* (what that mileage means for this model, what the trim includes). Prefer specific prose over lists of adjectives; agents extract more signal from "carbon plate, 4 mm drop, for 10–50 mi technical terrain" than from five keyword-stuffed sentences.
Verify: confirm both layers exist and agree — every computable attribute has a human explanation and vice versa. Evidence: the attribute↔narrative pairing for a sample product.

### Block C — Trust: consistency, freshness, reviews

**C1. Data is identical across page, feed, and every other source.** — **P0**
Requirement: the same fact (price, availability, identifier, spec) is identical on the product page, in the feed, and on any other surface (marketplace, profiles). Agents cross-check sources; a mismatch (page says one price, feed says another) makes the agent flag the data unreliable and **drop the product from consideration**.
Verify: diff the same fields across page ↔ feed ↔ one external source → identical. Evidence: the cross-source diff (mismatches = 0).
Why P0: inconsistency silently removes products from agent consideration, catalog-wide.

**C2. Stock and price are fresh; "in stock" is true at answer time.** — **P0**
Requirement: availability and price reflect reality with low latency. If an agent answers "in stock" and it is not, the brand gets flagged as an unreliable data source — a durable penalty. Stale feeds are now expensive.
Fork: **if the target surface ingests a periodic feed** → keep feed refresh frequent enough that stock/price are not materially stale. **If it queries a real-time endpoint** → ensure the endpoint returns live stock/price.
Verify: compare live stock/price to what the feed/endpoint exposes → match within an acceptable latency. Evidence: live-vs-exposed comparison + refresh interval.

**C3. Review signals are present and specific.** — **P1**
Requirement: genuine review signals (volume, recency, specificity) are available and, where shown on-page, marked up (Review/AggregateRating — shape owned by `structured-data-discipline`, but only if reviews are real and visible). Agents weight review trust in ranking.
Verify: confirm reviews are real, recent, specific, and (if marked up) parity-valid. Evidence: review presence + recency note.

### Block D — Feed & protocol posture (dated; verify before relying)

> **Dated snapshot — state as of June 2026. Protocols change every few months; re-verify names, costs, regional coverage, and adoption before acting. The principles above (A–C) do not expire; the specifics below do.**

**D1. Where AI shopping surfaces are fed by a product feed, the feed is clean and complete.** — **P0 (where the surface is a discovery target)**
Requirement: the feed that the relevant AI surface consumes is error-free and complete — valid product identifiers (e.g. GTIN where applicable), all required attributes, no price/availability mismatches, no missing-field suppressions. In the current landscape, **discovery is driven mainly by pre-submitted feeds**, not real-time agent API calls: AI shopping surfaces typically read a merchant feed as the primary source. A feed with errors makes the product invisible to that surface regardless of how good the page is.
Fork: the feed target depends on the surface and region — verify per target which feed/manifest a given AI surface ingests in your market.
Verify: run the feed platform's validation/diagnostics → 0 blocking errors, required attributes complete. Evidence: the feed validation report.

**D2. Protocol adoption is a deliberate, region-aware choice — not reflexive.** — **P2**
Requirement: decide protocol participation by target market, AI surface, and maturity — not by hype. Understand the current map before choosing:
- **MCP (Model Context Protocol)** — the connection layer ("USB-C for AI"); how agents reach tools/data/endpoints. Neutral-governed. Often the substrate other protocols ride on.
- **UCP (Universal Commerce Protocol)** — Google-led open standard combining discovery + agent-to-agent + payment; philosophy is *merchant keeps the data in its own domain* (agents request, merchant returns stock/price). Lower checkout cost than ACP in disclosed figures.
- **ACP (Agentic Commerce Protocol)** — OpenAI/Stripe; originally powered autonomous checkout, since **scaled back toward discovery** after low merchant adoption and higher cost.
- **AP2 / MPP / x402** — payment-layer protocols (secure agent payments / machine-to-machine), relevant only if/when you build agent checkout.
- **Regional fragmentation** — payment-agent standards differ by region (e.g. distinct frameworks and unifying platforms across markets). For an international company, the right protocol is **market-specific**; do not assume one global answer.
Decision rule: pursue **discovery legibility everywhere** (A–C, D1); pursue **checkout protocols only** where the market is mature, the surface supports it, and the ROI case is real (it frequently is not yet). Keep checkout with the brand by default.
Verify: a recorded decision per target market — which surfaces, which feed/manifest, whether checkout is in scope, and why. Evidence: the dated decision record + a freshness check of this section's facts.

---

## 6. Final gate — run before the commerce page/feed is "done"

Do not mark agent-readiness complete until every **in-scope** item is verified **with evidence**.

1. Walk Blocks A–D. For each applicable item, run its verification and record evidence (JS-disabled render, feed report, cross-source diff). No evidence → not done.
2. **P0 first:** if A1 (static price/stock), C1 (consistency), C2 (freshness), or D1 (feed errors, where applicable) fail, the product is **blocked** — it is either invisible to agents or feeding them false data. Fix before chasing P1/P2.
3. Apply progressive legibility: if you cannot complete everything, ship the P0/P1 discovery layer now and raise legibility next iteration — do not block visibility waiting for protocol perfection.
4. Record deliberate deferrals (especially Block D protocol choices) with market reasons. A silent skip is an oversight; a recorded deferral is a strategy.
5. Hand off owned-elsewhere layers: Product/Offer schema *shape and validity* → `structured-data-discipline`; static-HTML/indexability mechanics → `page-technical-seo`; prose → `geo-content-discipline`. The orchestrator coordinates.

If any P0 fails → not ready. If only P2 (protocol posture) remains → the product is discovery-ready and publishable; protocol decisions can follow deliberately.

---

## 7. Boundary cases — when items bend

- **Catalog/listing page vs product detail page**: listing → consistency and per-item attribute completeness for the items shown; detail → full A/B/C. Don't assert per-item availability on a listing if it isn't truly current.
- **Non-transactional catalog** (showcase, lead-gen, "enquire" rather than "buy" — e.g. a made-to-order or import catalog): discovery legibility (A–C) fully applies — agents still surface and compare; but checkout protocols (D2) are usually N/A, and the goal is "agent recommends, customer contacts the brand". This is the natural keep-checkout-with-the-brand case.
- **Market without mature agent-commerce surfaces**: A–C still pay off (the data feeds general AI answers and classic shopping); D2 protocol work waits until the market supports it.
- **Single high-value items vs mass SKUs**: the Golden Record (A2) is per-item hand-built for few high-value items, template-enforced for large catalogs — same outcome, different method.
- **Product is legible but still not surfaced**: agent-readiness is necessary, not sufficient. Check classic indexability (`page-technical-seo`), schema validity (`structured-data-discipline`), and content extractability (`geo-content-discipline`) before assuming a protocol gap.

---

## 8. Connections to other skills

- **`page-optimization-orchestrator`** — routes the agent-readiness layer here for commerce pages; this skill returns its gate result (P0 pass/fail + evidence).
- **`structured-data-discipline`** — owns Product/Offer/AggregateRating JSON-LD *shape, validity, and parity*; this skill owns the *agent-consistency, feed, and freshness* half. The on-page price in schema (that skill) must equal the feed price (C1 here).
- **`page-technical-seo`** — A1 (static-HTML price/stock) is the commerce-specific case of its B1 (content in server HTML); the wrapper must be sound for the product to be reachable at all.
- **`geo-content-discipline`** — owns the consumer-readable prose (B1 second layer); this skill requires that the agent-readable facts and the prose agree.
- **`real-path-verification`** — "done means validated with evidence" (Sections 1, 6): the JS-disabled render and feed report are the verified real path.
- **`skill-writing-standard`** — built under that standard (outcome-based items, third-person triggers, P0→P2 severity, anti-"Schema F" region-aware rule, honest maturity framing, dated-snapshot review note for the fast-moving protocol map).

---

## 9. Changelog

- **2026-06-12 — v1.0.** Initial skill. Technology/region-agnostic, prioritized (P0→P2) agent-readiness checklist: discovery legibility (static-HTML price/stock, Golden-Record attribute completeness, two-layer product data, cross-source consistency, freshness, review trust) as the mature do-now layer, and a dated, region-aware protocol-posture layer (UCP/ACP/MCP/AP2/MPP) marked for periodic re-verification. Honest maturity framing (discovery real, checkout immature → win discovery, keep checkout with the brand); progressive-legibility sequencing; anti-"Schema F" region-aware rule; boundary case for non-transactional/import catalogs; final gate with P0-first; series cross-references. Built from a 5×7 research pass (35 queries across 7 languages).
