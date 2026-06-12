---
name: page-technical-seo
description: Technology-agnostic, prioritized (P0→P2) checklist for the technical SEO/GEO wrapper of a web page — title, meta description, H1/heading semantics, URL/slug, canonical, robots/noindex, hreflang, Open Graph, sitemap inclusion, crawler indexability (server- vs client-rendered HTML, honest status codes, content reachable without interaction), crawl-budget hygiene, Core Web Vitals, internal linking, image alt. Use whenever a new page is created, an existing page is revised or audited, a site is migrated or relaunched, indexability is in question, or the page-optimization-orchestrator delegates the technical-wrapper layer. Each item is an outcome requirement plus a technology fork only where the result truly depends on the stack, plus a verification with evidence. Mandatory here — not optional. Do NOT use for the page's text/content (use geo-content-discipline), schema.org markup (use structured-data-discipline), product feeds or agent-commerce protocols (use agentic-commerce-readiness), or internal documentation.
---

# Page Technical SEO
<!--
  @file:        skills/page-technical-seo/SKILL.md
  @description: Technology-agnostic, prioritized (P0→P2) checklist for the technical
                SEO/GEO wrapper of a web page. Outcome requirements + technology forks
                + verification-with-evidence. Part of the "SEO + GEO optimization" skill series.
  @version:     1.0
  @updated:     2026-06-12
-->

---

## 1. Philosophy

The technical wrapper is the **infrastructure layer** of a page: not the words, not the schema, not the product feed — the title/meta/URL/indexability/performance shell that decides whether anything else on the page is ever seen. In 2026 this layer is a **hygiene precondition**, not a differentiator: if a page fails it, even excellent content is not evaluated in classic search or in AI answers. And the dependency is hard — **no indexing → no retrieval → no citation**: AI engines (ChatGPT, Perplexity, AI Overviews) mostly retrieve sources through traditional search indexes in real time, so a page that is not indexable is invisible to them too.

This skill is **outcome-based and technology-agnostic by design.** Each item states a result to achieve (WHAT), not a framework-specific recipe (HOW). Where the result genuinely depends on the stack, the item gives an explicit fork ("if the page is server-rendered … / if it is client-rendered …") rather than naming one framework. The reason is a documented failure mode: teams that apply a rigid stack-specific checklist blindly — "the checklist said go headless, so we went headless" — break indexing and performance on infrastructure they cannot maintain. A requirement must survive a change of stack, CMS, or country; if it would not, it is written wrong.

**Two operating principles:**

1. **Outcome over mechanism.** Every item is verified by *result achieved*, not by *mechanism installed*. "Title is unique, ≤60 chars, primary entity in first 30" — not "use the framework's metadata API".
2. **Done means validated, with evidence.** An item is complete only when its verification has been run and produced evidence (a view-source line, a status code, a tool reading). A checked box without evidence is "audit theater" — it hides the exact failures this skill exists to catch.

This skill owns only the technical wrapper. Text/content → `geo-content-discipline`. Schema.org markup → `structured-data-discipline`. Product feeds and agent-commerce protocols → `agentic-commerce-readiness`. It is necessary but not self-sufficient: a technically perfect page with empty content still loses.

---

## 2. Scope

### In scope
Title tag; meta description; H1 and heading hierarchy/semantics; URL & slug structure; canonical; robots meta / noindex; hreflang (multilingual/multi-region fork); Open Graph & Twitter Card; XML sitemap inclusion rules; crawler indexability (server-rendered vs client-rendered HTML, honest HTTP status codes, content reachable without interaction); crawl-budget hygiene (status codes, redirect chains, parameter/duplicate URLs); Core Web Vitals floor; internal linking & breadcrumbs; image alt text.

### Out of scope
- The **words on the page** — answer-first structure, statistics, quotes, paragraph discipline → `geo-content-discipline`
- **Schema.org / JSON-LD** markup and entity graph → `structured-data-discipline`
- **Product feeds, agent protocols (UCP/ACP/MCP), data consistency for buying agents** → `agentic-commerce-readiness`
- Internal docs, ADRs, prompts, code comments

If unsure: "Is this about the shell the crawler fetches, or the meaning inside it?" Shell → here. Meaning → content/schema skills.

---

## 3. Activation Triggers

1. **A new page of any type is being created** — product/listing/article/news/service/landing/static. The wrapper is set before publish.
2. **An existing page is being revised or audited** — any change to a live page, or a "why isn't this page ranking / cited?" question.
3. **Migration / relaunch / URL change** — the highest-risk moment for canonical, redirects, indexability.
4. **Indexability is in question** — page missing from search, "crawled — currently not indexed", traffic drop.
5. **The orchestrator delegates the technical layer** — `page-optimization-orchestrator` routes the wrapper checks here.

### Not a trigger
- Editing only the body text (→ `geo-content-discipline`)
- Adding only schema (→ `structured-data-discipline`)
- Touching only feeds/agent protocols (→ `agentic-commerce-readiness`)
- Internal documentation

---

## 4. How to read the checklist

Each item has three parts:

- **Requirement (WHAT)** — the outcome, stack-independent.
- **Fork** *(only when present)* — `if <technology condition> → … / if <other> → …`. A fork appears **only** where the correct action genuinely differs by technology (a "real constraint", not a leaked implementation detail). Most items have no fork.
- **Verify (evidence)** — an observable check that produces evidence. Default tools are universal: **view-source / `curl` for raw HTML**, **DevTools → Elements/Network**, **a field-data performance tool** (e.g. PageSpeed Insights / CrUX), **a crawler** (e.g. Screaming Frog / Sitebulb) for site-wide checks, **Search Console / Webmaster** for index state. Name the evidence, don't just tick the box.

**Priority tags** (apply per item; from real severity ordering):
- **P0 — blocker.** If wrong, the page is removed from the index or hidden from crawlers/AI. Nothing else matters until fixed. (Canonical errors, noindex leaks, client-only critical content, dishonest status codes.)
- **P1 — strong signal.** Materially affects ranking/CTR/AI extraction. (Title, H1, internal links, CWV floor, hreflang correctness.)
- **P2 — polish.** Real but smaller effect. (Meta description wording, OG image refinement, alt nuance.)

> **Project-context rule (anti-"Schema F").** This is a baseline, not a universal law. Before applying an item, ask: *does this page/site context actually need it?* A single-language site skips hreflang entirely; a no-parameter static site skips faceted-URL hygiene. Add items the project needs and skip items it does not — but record what you skipped and why, so "skipped" is a decision, not an oversight. Never apply a structural change (e.g. changing rendering mode) just because the list mentions it; apply it only if the verification shows the outcome is currently failing.

---

## 5. The checklist

### Block A — Meta core (priority order inside the block: canonical > title > description)

**A1. Canonical is correct and self-consistent.** — **P0**
Requirement: every indexable page declares a canonical URL pointing to an accessible, indexable, 200-status URL; for a standalone page that is itself (self-referencing canonical). Non-canonical duplicates (parameters, http/https, www/non-www, print/AMP variants) point to the one primary URL.
Verify: view-source / DevTools → `<head>` → `rel="canonical"` present and resolves to a 200 URL; the canonical target is not noindexed and not redirected. Evidence: the canonical line + status code of its target.
Why P0: a wrong canonical silently removes the whole page from the index — the single most destructive wrapper error.

**A2. Title is unique, sized, entity-first.** — **P1**
Requirement: title is unique across the site, ~50–60 characters, primary entity/keyword in the first ~30 characters, no boilerplate padding; distinct from the H1 (see C1).
Fork: none.
Verify: view-source `<title>`; site crawler → "duplicate titles" = 0 for indexable pages. Evidence: the title string + character count + crawler duplicate count.

**A3. Meta description is present, sized, specific.** — **P2**
Requirement: unique meta description ~140–160 chars (shorter is fine), specific and extractable (it is frequently lifted verbatim as the AI/search snippet), no duplication across pages. Accept that engines rewrite it often — write it for the cases they keep, and for AI extraction.
Verify: view-source `<meta name="description">`; crawler → duplicate descriptions = 0. Evidence: the description + length + duplicate count.

### Block B — Indexability for crawlers and AI bots (the layer most often silently broken)

**B1. Critical content is in the server-returned HTML.** — **P0**
Requirement: the page's primary content (main text, key facts, primary nav, canonical/meta tags) is present in the raw HTML the server returns, without executing JavaScript.
Fork: **if the page is server-rendered / statically generated / incrementally regenerated** → confirm the rendered HTML already contains the content. **If the page is client-rendered** (content fetched/painted by JS after load) → most AI crawlers (GPTBot, ClaudeBot, PerplexityBot, OAI-SearchBot, Meta) do **not** execute JS and will see an empty shell; move critical content to server-rendered output, or provide a server-rendered equivalent. (Googlebot and Applebot render JS; most AI bots do not — design for the lower common denominator.)
Verify: `curl` the URL (or view-source, or DevTools "view rendered vs raw") → the primary content and meta tags are present in the **raw** response, not only after JS. Evidence: the raw HTML excerpt showing the content.
Why P0: client-only content is invisible to AI bots → no retrieval → no citation.

**B2. Status codes are honest.** — **P0**
Requirement: a page that succeeds returns 200; a missing page returns 404/410; a moved page returns 301; a server failure returns 5xx. No "soft 200" — a client framework must not catch an error and return an error page **with a 200 status** (the "invisible 500"), which bots read as a thin page to deindex.
Fork: **if a client-side framework can swallow server/route errors** → ensure the real HTTP status is surfaced (error/not-found states return the correct code, not 200).
Verify: `curl -I` (or DevTools → Network → Status) on success, missing, and error URLs → status matches reality. Evidence: status codes for a success URL and a deliberately-wrong URL.

**B3. Indexability directives are intentional.** — **P0**
Requirement: indexable pages are **not** noindexed and **not** disallowed by robots in a way that hides them; pages that must stay out of the index use `noindex` (not just robots.txt `Disallow`, which does not prevent indexing when external links exist). robots.txt does not block CSS/JS/images needed to render. Staging/admin/thank-you/duplicate URLs are noindexed.
Verify: view-source `<meta name="robots">`; check robots.txt does not Disallow render resources; Search Console URL inspection → "indexable". Evidence: robots meta value + index state.

**B4. Content is reachable without interaction.** — **P1**
Requirement: navigation and key content exist in the DOM without requiring a click/hover (e.g. a menu whose links are injected only after opening a hamburger is invisible to crawlers).
Verify: disable JS / inspect raw DOM → primary links and content present. Evidence: raw-DOM note showing nav links exist pre-interaction.

### Block C — Headings & semantics

**C1. Exactly one H1, distinct from title, describing the page.** — **P1**
Requirement: one `<h1>` per page containing the primary topic; it is **related but not identical** to the title (title is tuned for the SERP — short, clickable; H1 is tuned for on-page reading — can be longer/descriptive). Heading hierarchy (H2/H3) is logical and reflects content structure.
Verify: view-source / DevTools → exactly one `<h1>`; compare with `<title>`; outline reads logically. Evidence: the H1 text + count + title-vs-H1 note.

### Block D — URL & crawl-budget hygiene

**D1. Clean, stable, descriptive URL/slug.** — **P1**
Requirement: URL is human-readable, lowercase, hyphenated, describes the page, avoids needless parameters/session IDs, stable over time. One canonical URL per piece of content.
Verify: read the URL; crawler → no duplicate/parameter explosions for this content. Evidence: the URL + crawler duplicate note.

**D2. No broken links or redirect chains from/to the page.** — **P1**
Requirement: internal links resolve to 200s; redirects are single-hop 301 (no chains/loops); the page is not orphaned (at least one internal link points to it). AI crawlers waste disproportionate budget on 404s/redirects and crawl far more often than Googlebot — clean status hygiene matters more, not less.
Verify: crawler → status of outbound/inbound links, redirect-hop count; confirm ≥1 internal inbound link. Evidence: redirect-hop counts + inbound-link count.

**D3. Page is included in the sitemap correctly (if indexable).** — **P2**
Requirement: indexable page appears in an XML sitemap; the sitemap contains **only** canonical, 200, indexable URLs (no 404/redirected/noindexed/canonicalized-away/parameter URLs); `<lastmod>` reflects real last modification (AI and search bots use it as a freshness signal).
Verify: open sitemap → URL present; spot-check that listed URLs are 200/canonical. Evidence: sitemap entry + a couple of status checks.

### Block E — International (apply only if the page has language/region variants)

**E1. hreflang is complete and self-consistent.** — **P1** *(skip entirely if single-language/single-region)*
Requirement: each variant declares the full hreflang set including a self-reference and **mutual return references** to every other variant; correct ISO language/region codes; an `x-default` fallback where appropriate; hreflang targets are indexable and self-canonical (no canonical↔hreflang conflict). Exactly one URL per language/region pair (duplicates make Google ignore the whole set).
Fork: present only when variants exist; otherwise the entire item is N/A.
Verify: hreflang testing tool / crawler hreflang report → return links complete, codes valid, no canonical conflict. Evidence: the hreflang cluster + tester result.

### Block F — Social preview

**F1. Open Graph / Twitter Card present and accurate.** — **P2**
Requirement: `og:title`, `og:description`, `og:image`, `og:url` (and Twitter `summary_large_image`) present, accurate, with a correctly-sized image; values consistent with the page's real title/description.
Verify: view-source `<head>` OG/Twitter tags; a social-preview validator renders correctly. Evidence: OG tag set + validator screenshot/note.

### Block G — Performance floor (Core Web Vitals)

**G1. Core Web Vitals meet the floor on field data.** — **P1**
Requirement: field-data (not only lab) thresholds met — LCP ≤ 2.5 s, INP ≤ 200 ms, CLS ≤ 0.1; TTFB kept low (a TTFB > ~800 ms is a warning sign). Treat this as a hygiene floor, not a competitive edge: meeting it is necessary, exceeding it is not a differentiator.
Fork: none at the requirement level (the *fixes* differ by stack — image format/preload for LCP, script-splitting/deferral for INP, dimensions/reserved space for CLS, CDN/server for TTFB — but the *outcome* is identical everywhere).
Verify: field-data tool (PageSpeed Insights / CrUX / Search Console CWV report) → the three metrics in "Good". Evidence: the three field values + source.

### Block H — Images

**H1. Images have meaningful alt text; modern formats; sane loading.** — **P2**
Requirement: informative images have descriptive alt text (decorative images use empty alt); next-gen formats (WebP/AVIF) where supported; offscreen images lazy-loaded but the LCP/hero image **not** lazy-loaded.
Verify: view-source / DevTools → alt attributes present and meaningful; hero image not lazy. Evidence: alt sample + hero loading note.

---

## 6. Final gate — run before the page is "done"

Do not mark the page complete until every **in-scope** item has been verified **with evidence**.

1. Walk Blocks A–H. For each applicable item, run its verification and record the evidence (status code, view-source line, tool reading). An item with no evidence is **not** done.
2. **P0 first:** if any P0 item fails, the page is **blocked** — fix before anything else, because P0 failures remove the page from the index or hide it from bots, nullifying all other work.
3. Mark skipped items explicitly with a reason ("single-language site → E1 N/A"). A silent skip is an oversight; a recorded skip is a decision.
4. Hand off the layers this skill does not own: confirm `geo-content-discipline` (text), `structured-data-discipline` (schema), and — for catalog/product pages — `agentic-commerce-readiness` (feeds/agents) have been or will be run. The orchestrator coordinates this.

If any P0 fails → page not ready, full stop. If only P2 items remain → page is publishable; log them as follow-ups.

---

## 7. Boundary cases — when items bend

- **Intentionally non-indexed page** (thank-you, internal tool, gated): B3 inverts — the *requirement* is a correct `noindex`; A/D/G still apply for the humans who reach it, E/F often N/A.
- **Listing/catalog index page** vs **detail page**: both run the wrapper, but D (parameter/faceted-URL hygiene, pagination canonicals) weighs heavily on listings; B1 (server-rendered items) is critical on detail pages whose data is often client-fetched.
- **Single-language project**: Block E is entirely N/A — skip and record.
- **Static no-parameter site**: faceted-URL parts of D are N/A.
- **The page is fine technically but not cited/ranked**: this skill is necessary, not sufficient. Escalate to `geo-content-discipline` (is the content extractable?) and `structured-data-discipline` (is the entity legible?). Do not keep re-tuning the wrapper past green.

---

## 8. Connections to other skills

- **`page-optimization-orchestrator`** — routes the technical-wrapper layer here; this skill returns its gate result (P0 pass/fail + evidence) to the orchestrator.
- **`geo-content-discipline`** — owns the text inside the page (answer-first, statistics, headings-as-questions). C1 here governs the H1 *element*; that skill governs heading *wording*. No overlap.
- **`structured-data-discipline`** — owns JSON-LD/schema. A1/B1 here ensure the schema is reachable in server HTML; that skill defines the schema itself.
- **`agentic-commerce-readiness`** — for product/catalog pages, owns feeds, agent protocols, and on-page↔feed data consistency. B-block indexability is the precondition for any of it.
- **`real-path-verification`** — the "done means validated with evidence" rule (Section 1, Section 6) is this skill's expression of real-path verification: the evidence *is* the verified real path.
- **`skill-writing-standard`** — this skill was built under that standard (outcome-based items, third-person triggers, P0→P2 severity, project-context anti-"Schema F" rule).

---

## 9. Changelog

- **2026-06-12 — v1.0.** Initial skill. Technology-agnostic, prioritized (P0→P2) technical-wrapper checklist across 8 blocks (meta core, indexability for AI bots, headings, URL/crawl-budget, international, social, CWV floor, images), each item as outcome-requirement + optional technology fork + verification-with-evidence; final gate with P0-first rule; project-context anti-"Schema F" rule; boundary cases; series cross-references. Built from a 5×7 research pass (35 queries across 7 languages).
