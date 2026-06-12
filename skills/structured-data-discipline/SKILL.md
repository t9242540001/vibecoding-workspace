---
name: structured-data-discipline
description: Technology-agnostic, prioritized (P0→P2) checklist for the structured-data / machine-readability layer of a web page — schema.org JSON-LD by page type (Product, Article, Organization, LocalBusiness, BreadcrumbList, FAQPage with current rich-result status), content parity (every marked-up fact visible on the page), entity depth via @graph/@id and Wikidata, freshness (ISO-8601 dates, dateModified), validation, and llms.txt. Use whenever a new page is created, an existing page is revised or audited, schema is added or changed, entity legibility is in question, or the page-optimization-orchestrator delegates the machine-readability layer. Frames schema honestly as RAG-grounding infrastructure, not a citation guarantee. Each item is an outcome requirement plus verification. Mandatory here — not optional. Do NOT use for page text/content (use geo-content-discipline), the technical wrapper (use page-technical-seo), product feeds or agent-commerce protocols (use agentic-commerce-readiness), or internal documentation.
---

# Structured Data Discipline
<!--
  @file:        skills/structured-data-discipline/SKILL.md
  @description: Technology-agnostic, prioritized (P0→P2) checklist for the structured-data /
                machine-readability layer of a web page. Schema.org/JSON-LD by page type,
                content parity, entity depth (@graph/@id/Wikidata), freshness, validation-with-evidence,
                llms.txt. Part of the "SEO + GEO optimization" skill series.
  @version:     1.0
  @updated:     2026-06-12
-->

---

## 1. Philosophy

Structured data is how a page tells machines **what it is, who it is about, and how its facts relate** — in a form they do not have to guess from raw HTML. This is the machine-readability layer: schema.org expressed as JSON-LD, plus the site-level entity files (llms.txt) that sit beside it.

**Frame it honestly.** Schema is **not** a citation guarantee. Independent studies have found no reliable correlation between schema coverage alone and AI citation rate. Its value is **infrastructural**: it grounds retrieval-augmented generation (RAG) with clean facts, resolves which entity a page is about, disambiguates your brand from others, and feeds the entity graphs that AI systems use to decide which source to trust. Treat schema as connective tissue and a trust signal, not magic. The corollary matters: because AI systems consume schema as a **fact source**, **invalid or dishonest markup is worse than none** — it can trigger penalties and erode the very authority it was meant to build.

This skill is **outcome-based and technology-agnostic.** Each item states a result (WHAT) — "every marked-up fact is visible on the page", "dates are ISO-8601 with timezone", "one main entity per URL" — not a CMS- or framework-specific recipe. A requirement must survive a change of stack, plugin, or country.

**Two operating principles:**

1. **Outcome over mechanism.** Verified by *result achieved* (a validator pass, a visible-content match), not by *which generator produced the JSON-LD*.
2. **Done means validated, with evidence.** An item is complete only when its verification has run and produced evidence — a Rich Results Test / Schema Markup Validator result, a view-source JSON-LD block, a visible-vs-marked-up diff. A checked box without evidence is theater, and here it is dangerous: unvalidated schema can actively harm.

Boundaries: page text → `geo-content-discipline`. Technical wrapper (title/meta/URL/indexability) → `page-technical-seo`. Feeds and agent protocols → `agentic-commerce-readiness`. This skill owns only the schema/entity layer — and it depends on the technical layer: schema must be reachable in the server-returned HTML (most AI crawlers do not run JS), which `page-technical-seo` B1 guarantees.

---

## 2. Scope

### In scope
JSON-LD syntax and delivery (`@context`, `@type`, `@id`, `@graph`, script placement, escaping); schema profile **per page type** (Product, Article/NewsArticle, Organization, LocalBusiness, BreadcrumbList, FAQPage, WebPage/WebSite, Person); content parity (marked-up ↔ visible); entity depth and linking (`@graph`/`@id` nesting, `mentions`/`about` with Wikidata IDs, `mainEntityOfPage` vs `about`); freshness (`datePublished`/`dateModified`, ISO-8601 with timezone); single-source-of-fact consistency; validation workflow; current rich-result status of each type (FAQ/HowTo); the site-level `llms.txt` entity file.

### Out of scope
- The **words/content** that schema describes (answer-first, statistics, quotes) → `geo-content-discipline`
- The **technical wrapper** (title, meta, canonical, indexability, status codes, CWV) → `page-technical-seo`
- **Product feeds, agent protocols (UCP/ACP/MCP), on-page↔feed data consistency for buying agents** → `agentic-commerce-readiness`
- Internal docs, ADRs, prompts, code comments

If unsure: "Is this about *how machines model the page's entities and facts*, or about the page's *wrapper / words / feeds*?" Entities & facts → here.

---

## 3. Activation Triggers

1. **A new page of any type is being created** — it needs the right schema profile before publish.
2. **An existing page is revised or audited** — content changed (so `dateModified` and parity change), or "is this page legible to AI as an entity?"
3. **Schema is added, changed, or migrated** — new type, refactor to `@graph`, schema.org version bump.
4. **Entity legibility is in question** — brand returns wrong/stale info in AI answers; knowledge-panel issues.
5. **The orchestrator delegates the machine-readability layer** — `page-optimization-orchestrator` routes schema/entity checks here.

### Not a trigger
- Editing only body text (→ `geo-content-discipline`)
- Editing only title/meta/URL/indexability (→ `page-technical-seo`)
- Touching only feeds/agent protocols (→ `agentic-commerce-readiness`)
- Internal documentation

---

## 4. How to read the checklist

Each item has: **Requirement (WHAT)** — the outcome, stack-independent; **Fork** *(only where present)* — `if <condition> → … / if <other> → …`, used only where the correct action genuinely differs by page type or context; **Verify (evidence)** — an observable check producing evidence. Default tools are universal: **Schema Markup Validator (validator.schema.org)** and **Google Rich Results Test** for validity/eligibility; **view-source / DevTools** to confirm the JSON-LD is in the server HTML; a **visible-vs-marked-up diff** for parity; **Search Console structured-data report** for index-side state.

**Priority tags:**
- **P0 — harmful if wrong.** Markup that is invalid, dishonest (claims facts not on the page), or contradictory. These can trigger manual actions or feed AI false data — fix before anything else. Better no schema than broken schema.
- **P1 — strong machine-readability signal.** Correct profile for the page type, entity nesting, freshness — materially affects how machines understand and retrieve the page.
- **P2 — useful infrastructure.** Smaller or less-proven effect (extended Organization properties, llms.txt, social-adjacent types).

> **Project-context rule (anti-"Schema F").** This is a baseline, not a mandate to stamp every type onto every page. Over-marking is itself an anti-pattern: add **only** the types the page's actual content supports, and add the smallest profile that is true. A page with no genuine Q&A does not get FAQPage; a page that is not a product does not get Product. Before adding a type, ask: *does the visible content of this page actually justify it?* Record types deliberately omitted, so "omitted" is a decision, not an oversight. Never add markup for content that is not visible (that is the P0 parity violation, not optimization).

---

## 5. The checklist

### Block A — Validity & parity (the do-no-harm core)

**A1. Every page with schema validates clean.** — **P0**
Requirement: all JSON-LD on the page passes the Schema Markup Validator with no errors; eligible types pass the Rich Results Test; JSON is well-formed (no unescaped characters, no trailing-comma/syntax breaks); no deprecated types; no two blocks declaring the same type with contradictory values.
Verify: run validator.schema.org + Rich Results Test on the URL (or pasted code) → zero errors. Evidence: the validator result (errors = 0) for this page.
Why P0: invalid schema is ignored at best and treated as a trust/spam problem at worst — worse than no schema.

**A2. Content parity — every marked-up fact is visible on the page.** — **P0**
Requirement: every property asserted in JSON-LD (price, rating, author, date, answer text, attributes) corresponds to content actually visible to a human on the rendered page. No "schema-only" facts, no marked-up FAQ that is not shown on the page.
Verify: diff the JSON-LD properties against the visible page content → 100% of marked-up facts are present on-page. Evidence: the parity check (marked-up list vs visible list, mismatches = 0).
Why P0: mismatch is classified as deceptive/"spammy structured data" → manual action, revocation of rich features, lost trust.

**A3. One main entity per URL; supporting entities are relational, not competing.** — **P1**
Requirement: each URL has exactly one dominant entity (the thing the page is about), declared via `mainEntityOfPage` (or as the primary node in the graph); use `about` when the page covers several topics without one subject. Additional nodes (WebPage, Organization, BreadcrumbList) are supporting, not competing for "the main topic".
Verify: read the JSON-LD graph → one unambiguous main entity; supporting nodes clearly subordinate. Evidence: which node is main + how supporting nodes attach.

### Block B — Entity depth & linking

**B1. Entities are nested and cross-referenced with stable @id, ideally in one @graph.** — **P1**
Requirement: related entities are connected, not isolated — e.g. Article → `author` (Person) → and `publisher` (Organization); Product → relevant Organization/Manufacturer; each reusable entity has a stable `@id` so it is referenced once and pointed to, not duplicated with drifting values. Prefer a single `@graph` block with `@id` cross-references over many disconnected script blocks.
Verify: read the graph → entities reference each other by `@id`; no duplicated entity with conflicting fields. Evidence: the `@id` reference map.

**B2. Key entities link out to authoritative identifiers (where they exist).** — **P2**
Requirement: where the page's main entity or important mentioned entities have authoritative IDs (e.g. Wikidata), connect them via `sameAs` (for the entity itself) and `mentions`/`about` (for referenced entities). This strengthens entity resolution in machine knowledge graphs.
Fork: applies only where an authoritative ID exists; skip otherwise.
Verify: check `sameAs`/`mentions` resolve to valid authoritative URLs. Evidence: the linked IDs.

**B3. Single source of fact — no contradictions across pages.** — **P1**
Requirement: the same business fact (name, address, phone, founding date, price) is identical everywhere it is marked up across the site (and, ideally, across the brand's web presence). Cross-platform consistency is a top machine-trust signal; contradictions make AI treat the data as unreliable.
Verify: spot-check the same fact in schema on 2–3 pages (and the public profiles) → identical. Evidence: the cross-page comparison.

### Block C — Profile per page type

**C1. The page carries the correct schema profile for its type.** — **P1**
Requirement: apply the type that matches the page's real purpose and visible content:
- **Product / offering page** → `Product` (or its specialization) with nested `Offer` (price, priceCurrency, availability, itemCondition, priceValidUntil); `AggregateRating`/`Review` only if real reviews are shown.
- **Article / guide** → `Article`; **news item** → `NewsArticle`; with `author` (named), `publisher`, `datePublished`, `dateModified`, `image` (with dimensions), `headline`.
- **Organization / about / contact** → `Organization` (and `LocalBusiness` where there is a physical/local presence) with name, logo, `sameAs`, contact, and entity-deepening properties (`foundingDate`, `founder`, `knowsAbout`) where supported by visible content.
- **Every page** → `BreadcrumbList` reflecting the real navigation path.
- **Q&A content actually shown on the page** → `FAQPage` (see C2 for status).
Fork: the type is chosen by page type; do not stack types the content does not support (parity, A2).
Verify: confirm the chosen type matches the page purpose and required properties are present and visible. Evidence: type + required-property checklist for that type.

**C2. FAQ / HowTo are handled per current reality, not the old playbook.** — **P1**
Requirement:
- **FAQ rich results were retired (May 7, 2026)** — FAQPage no longer produces the SERP accordion, and FAQ data is being removed from Search Console reporting/API through mid-2026. **Do not** add FAQPage expecting a rich result, and **do not** justify it by CTR uplift. **Do** keep/add FAQPage where genuine Q&A is visible on the page: it remains a valid machine-readability and AI/voice citation signal (Google states it need not be removed). Do **not** mark up FAQ that is not shown on the page (parity).
- **HowTo rich results were retired earlier** — do not invest in new HowTo markup for SERP features; for step content, use an ordered list (`<ol>`) inside `Article` plus clear heading structure.
Verify: confirm FAQPage is used only with on-page Q&A and not sold as a rich-result win; confirm no new HowTo is added for SERP purposes. Evidence: note of FAQ/HowTo decision + parity check.

### Block D — Freshness & dates

**D1. Dates are correct, formatted, and honest.** — **P1**
Requirement: `datePublished` and `dateModified` present where the type expects them; both in **ISO-8601 with timezone** (e.g. `2026-06-12T09:00:00+03:00`), not locale strings; `dateModified` reflects a **real** content change (not auto-bumped on every deploy, not left stale on changed content). Freshness is a real ranking/citation signal — and a false-fresh or stale-fresh date misleads it.
Verify: view-source the date fields → ISO-8601 + timezone; the `dateModified` matches the last real edit. Evidence: the date strings + last-edit cross-check.

### Block E — Site-level entity file

**E1. llms.txt exists and describes the site's key pages/entities.** — **P2**
Requirement: a root `llms.txt` (Markdown) is present, listing the site's primary pages and what the site is about, in the conventional structure (H1 site name, a one-line summary, H2 sections linking key pages/resources). Keep it accurate and current.
Context note (not a reason to skip): Google does not use llms.txt for ranking and confirmed crawler adoption is still limited — so this is P2, included because it is low-cost, does not harm, and aids agent/LLM comprehension. Do not over-claim its effect.
Verify: fetch `/<root>/llms.txt` → present, valid Markdown, lists the real key pages. Evidence: the file contents + a link check.

---

## 6. Final gate — run before the page is "done"

Do not mark the schema layer complete until every **in-scope** item is verified **with evidence**.

1. Walk Blocks A–E. For each applicable item, run its verification and record evidence (validator result, parity diff, view-source block). No evidence → not done.
2. **P0 first:** if A1 (validity) or A2 (parity) fails, the page is **blocked** — broken or dishonest schema actively harms (penalty, false AI data), so it must be fixed or removed before anything else. With schema, "remove it" is a legitimate fix when it cannot be made valid and parity-true.
3. Record types deliberately omitted, with reason ("no real Q&A → no FAQPage"). A silent omission is an oversight; a recorded one is a decision. Over-marking is as wrong as under-marking.
4. Confirm the dependency and hand off: schema must be reachable in server HTML (`page-technical-seo` B1); the words it describes are owned by `geo-content-discipline`; product feeds/agent consistency by `agentic-commerce-readiness`. The orchestrator coordinates.

If any P0 fails → page not ready (fix or remove the offending markup). If only P2 remain → publishable; log as follow-ups.

---

## 7. Boundary cases — when items bend

- **Page with no schema-worthy entity** (thin utility page): the correct outcome may be **minimal or no** schema beyond WebPage/Breadcrumb. Absence is a valid result; do not invent entities to mark up.
- **Listing/catalog page** vs **detail page**: listing → `BreadcrumbList` + optionally `ItemList`; detail → the full per-type profile (Product/Article). Don't put item-level Product schema on the listing unless each item's data is genuinely present.
- **News vs evergreen article**: `NewsArticle` vs `Article`; news weights `datePublished`/freshness more heavily.
- **FAQ content exists but is collapsed/accordion**: still parity-valid as long as the text is in the page DOM and shown on interaction within the page; it is not parity-valid if it exists only in JSON-LD.
- **Schema is perfect but brand still mis-cited by AI**: schema is necessary, not sufficient. Escalate to entity consistency across the web (B3), `geo-content-discipline` (is the fact stated extractably in the text?), and off-site presence. Don't keep adding schema types past green.

---

## 8. Connections to other skills

- **`page-optimization-orchestrator`** — routes the machine-readability layer here; this skill returns its gate result (P0 pass/fail + evidence).
- **`page-technical-seo`** — owns the wrapper; its B1 (content in server HTML) is the precondition for this skill (AI crawlers must see the JSON-LD without running JS); its sitemap `<lastmod>` and this skill's `dateModified` should agree.
- **`geo-content-discipline`** — owns the words. A2 (parity) here is the bridge: this skill requires that the facts it marks up are present in the text that skill governs. FAQ *wording* is content; FAQ *markup status* (C2) is here.
- **`agentic-commerce-readiness`** — for product/catalog pages, owns feeds and agent protocols; Product/Offer schema here is the on-page half, that skill owns the feed half and their consistency.
- **`real-path-verification`** — "done means validated with evidence" (Sections 1, 6) is this skill's real-path verification: the validator result and parity diff are the verified real path.
- **`skill-writing-standard`** — this skill was built under that standard (outcome-based items, third-person triggers, P0→P2 severity, anti-"Schema F" project-context rule, honest framing of contested effects).

---

## 9. Changelog

- **2026-06-12 — v1.0.** Initial skill. Technology-agnostic, prioritized (P0→P2) machine-readability checklist across 5 blocks (validity & parity, entity depth & linking, profile-per-page-type, freshness, site-level llms.txt), each item as outcome-requirement + optional fork + verification-with-evidence; honest framing of schema as RAG-grounding/entity infrastructure rather than citation guarantee; current FAQ/HowTo rich-result retirement reality (FAQ retired 2026-05-07, HowTo earlier; keep FAQPage for AI/voice, no new HowTo); content-parity and validity as P0 do-no-harm core; anti-"Schema F" project-context rule covering over-marking; final gate with P0-first and "remove is a valid fix" rule; boundary cases; series cross-references. Built from a 5×7 research pass (35 queries across 7 languages).
