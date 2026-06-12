---
name: page-optimization-orchestrator
description: The entry door and router for the SEO+GEO optimization skill series. Use whenever a web page of any type is created, revised, audited, migrated, or relaunched, or a set of pages is optimized in batch — this skill fires first, classifies the page by intent and commerciality, decides which optimization layers apply and at what profile, and delegates in priority order (P0 first) to four layer skills — page-technical-seo (technical wrapper), structured-data-discipline (machine-readability/schema), agentic-commerce-readiness (product/catalog pages for AI buying agents), and geo-content-discipline (page text). It collects each layer's gate result with evidence, holds the page-vs-site boundary, and runs a consolidated final gate. It routes and synthesizes — it does not duplicate the layer checklists. AI-assisted, human-led. Mandatory first step of any page-optimization task. Do NOT use when work is confined to a single layer (call that layer directly), for internal documentation, or for tasks that produce no page.
---

# Page Optimization Orchestrator
<!--
  @file:        skills/page-optimization-orchestrator/SKILL.md
  @description: Entry door + router for the "SEO + GEO optimization" skill series. Classifies the page,
                routes to the four layer skills (technical / structured-data / agentic-commerce / content)
                in P0-first order, collects gate results with evidence, holds the page-vs-site boundary,
                runs a consolidated final gate. Routes and synthesizes; does not duplicate layer checklists.
  @version:     1.1
  @updated:     2026-06-12
-->

---

## 1. Philosophy

This is the **entry door** of the SEO+GEO optimization series. When a page is created or revised, this skill fires first, works out **what kind of page it is**, decides **which layers apply and how deeply**, delegates the work to the layer skills in **priority order**, and then **synthesizes** their results into one go/no-go. It exists because the failure mode that started this series was not "we lack a checklist" — it was "no single trigger ensured every relevant layer actually ran on every page". A page would ship with good content but a broken canonical, or perfect schema but client-only price. The orchestrator is the guarantee that nothing is silently skipped.

**It routes; it does not re-do the work.** The four layer skills own their checklists. This skill must not copy or paraphrase their items — duplication would let the two drift and contradict. It classifies, sequences, collects evidence, and decides. Each layer is invoked, runs its own gate, and returns a P0 pass/fail with evidence; the orchestrator assembles those into the page's verdict.

**Three principles govern the routing:**
1. **No universal template.** Applying one fixed profile to every page is a documented way to fail — a transactional product page and an informational guide need different layers at different depths. Classify first, then route. (And one template across page types or industries usually fails.)
2. **P0 first, by leverage — not alphabetically or in list order.** Across audits, the first handful of issues explain the large majority of visibility loss. Sequence blockers (indexability, canonical, consistency) before polish; a P0 failure in any layer blocks the page regardless of how good the other layers are.
3. **Done means validated, with evidence; the human decides.** This is AI-assisted, human-led: the orchestrator routes, runs reviews, and assembles evidence, but the judgment and the responsibility stay with the human (Vasily). A gate "passes" only on collected evidence, never on a ticked box.

**Honesty about scope (page vs site).** A page is not optimized in a vacuum. Modern ranking and AI-citation weigh **site-level trust**: a weak overall site can suppress an otherwise-perfect page (domain-wide demotion), and indexation itself is often an authority problem, not only a technical one. This skill optimizes the **page** and **flags** site-level dependencies (topic-mesh/internal-link architecture, domain authority, sitewide canonical/redirect planning) as a separate level of work — it does not pretend a per-page pass guarantees ranking, and it does not perform sitewide architecture itself.

---

## 2. Scope

### In scope
Classifying the page (by search intent, funnel stage, commerciality); deciding which layers apply and at what profile; sequencing delegation P0-first; invoking the four layer skills and collecting their gate results with evidence; holding the page-level vs site-level boundary (flagging sitewide dependencies without performing them); the consolidated final gate; progressive sequencing across a batch of pages; handing off measurement.

### The four layer skills it routes to
- **`page-technical-seo`** — the technical wrapper (title/meta/H1/URL/canonical/indexability/status codes/CWV/internal links).
- **`structured-data-discipline`** — machine-readability (schema.org/JSON-LD, parity, entity depth, freshness, llms.txt).
- **`agentic-commerce-readiness`** — product/catalog pages for AI buying agents (agent-readable attributes, feed, consistency, discovery-vs-checkout).
- **`geo-content-discipline`** — the page text (answer-first, statistics, quoted authority, headings, anti-patterns).

### Out of scope
- **The layer checks themselves** — they live in the four skills above; this skill never duplicates them.
- **Writing the content** (→ `geo-content-discipline`) or implementing any single layer's fixes.
- **Sitewide architecture as implementation** (topic mesh, domain-authority building, sitewide redirects) — the orchestrator *flags* these as separate work; it does not execute them.
- **Measuring AI visibility after the fact** (→ `ai-visibility-measurement-ritual`).
- Internal docs; tasks that produce no page.

If unsure: "Am I coordinating *which layers run on this page and whether it's done*, or am I doing *one layer's actual work*?" Coordinating → here. One layer's work → that layer skill.

---

## 3. Activation Triggers

1. **A new page of any type is being created** — orchestrator fires before publish.
2. **An existing page is being revised or audited** — including "why isn't this page ranking / cited?".
3. **A migration or relaunch** — pages change URL/structure; the highest-risk moment.
4. **"Bring page X up to our SEO/GEO standard."**
5. **A batch of pages is being optimized** — the orchestrator sequences the set.

### Not a trigger
- Work deliberately confined to one layer → call that layer skill directly (e.g. "just fix the schema" → `structured-data-discipline`).
- Internal documentation.
- Tasks with no page as output.

> If a request *looks* single-layer but the page is new or broadly broken, prefer the orchestrator — it is cheap to run and its job is to catch the layer you would otherwise forget.

---

## 4. Step 1 — Classify the page (principle, not a fixed table)

Do **not** match the page against a hard-coded list of page types — page types vary by project, market, and business, and a fixed table goes stale or mis-fits. Instead, classify by asking a few questions; the answers determine which layers apply and at what depth.

**Q1 — What is the dominant user intent / funnel stage?**
- *Informational* (learn, how-to, definition; top-of-funnel) → text legibility and extractability dominate.
- *Commercial investigation* (compare, review, "X vs Y"; mid-funnel) → text + structured comparison + trust signals.
- *Transactional* (buy, enquire, sign up; bottom-of-funnel) → the offering's machine-readability and trust dominate.
- *Navigational* (brand/entity destination) → entity/identity clarity dominates.
- Mismatch is costly: a transactional page answering an informational query (or vice versa) loses. Confirm the intent matches the page's job before routing.

**Q2 — Is this a commerce surface (a product, offering, or catalog the user can buy or enquire about)?**
- If yes → the agentic-commerce layer is in play (even for "enquire", not just "buy" — see that skill's non-transactional boundary case).
- If no → the agentic-commerce layer is N/A.

**Q3 — Is it a single detail page or a listing/index page?**
- *Detail* → full per-page profile across the applicable layers.
- *Listing/index* → emphasis shifts to URL/crawl-budget hygiene, breadcrumb/ItemList structure, and per-item consistency; lighter on per-item deep schema.

**Q4 — Does it have language/region variants?**
- If yes → the international parts of the technical layer (hreflang) are in play.
- If no → skip them.

*Illustrative only (not an exhaustive or binding list — add the types your project actually has):* a product/vehicle card, a catalog/listing page, a how-to article, a news item, a service/landing page, a static informational page. Each maps to a different mix of layers via the questions above — classify by the questions, not by the label.

---

## 5. Step 2 — Route to the layers (which apply, and the order)

From the classification, decide **which** layers apply, then run them **P0-first**.

**Which layers apply (by the questions above):**
- **`page-technical-seo`** — **always.** Every page has a technical wrapper; if it fails, nothing else is seen. (Its international items run only if Q4 = variants exist.)
- **`structured-data-discipline`** — **almost always**, with the profile chosen by type (Article for a guide, Product for an offering, Organization/LocalBusiness for an about page, BreadcrumbList everywhere; FAQPage only where genuine on-page Q&A exists). A thin utility page may legitimately carry minimal/no schema — that skill decides.
- **`agentic-commerce-readiness`** — **only if Q2 = commerce surface.** Skip entirely for non-commerce pages.
- **`geo-content-discipline`** — **whenever the page has substantive text** (almost always except pure-utility pages). Depth scales with intent (heaviest for informational/commercial content).

**The order (P0-first across layers, not layer-by-layer-to-completion):**
1. **Indexability & wrapper P0 first** (`page-technical-seo`): if the page can't be crawled / is canonical-broken / returns dishonest status / hides critical content behind JS, fix that before anything else — every other layer is wasted on an invisible page.
2. **Then machine-readability and (if commerce) agent-readiness P0** (`structured-data-discipline` parity/validity; `agentic-commerce-readiness` static price/stock, consistency, freshness) — these are do-no-harm blockers (invalid schema, false agent data).
3. **Then content** (`geo-content-discipline`) and the P1/P2 of every layer — the depth work, once the page is reachable and not feeding false data.

Each invoked skill runs **its own** checklist and final gate and returns a **P0 pass/fail + evidence**. The orchestrator does not re-evaluate the items; it consumes the verdicts.

---

## 6. Step 3 — Flag site-level dependencies (don't perform them here)

Before closing, note any **site-level** factors that a per-page pass cannot fix, so they become explicit follow-up work, not silent gaps:
- **Domain/site trust** — if the page is technically and contentually clean but the wider site is weak (thin/duplicative pages, no authority), ranking/citation may still lag. This is sitewide work, not a page fix.
- **Internal-link / topic-mesh architecture** — is this page connected into a pillar/cluster structure and linked from relevant pages? Orphaned strong pages underperform. (The page-level internal-link *item* lives in `page-technical-seo`; the *architecture* is sitewide.)
- **Sitewide canonical/redirect/URL planning** — these are best planned across the site, not patched per page. **On a URL change in particular: a 301 alone is not "done" — every inbound internal link across the site (catalog/listing links, cross-link/related blocks, navigation, sitemap) must be repointed directly to the new URL. A single page cannot see all the links pointing *to* it, so this inbound-link sweep is a site-level step the orchestrator flags whenever a page's URL changes.** (The page-level half — a page's own outbound links and its own URL change — lives in `page-technical-seo` D2/D4.)
- **Cross-platform entity consistency** — brand facts must agree across the site and off-site profiles (owned in part by `structured-data-discipline` B3, but the off-site half is sitewide).

Record these as flagged items with an owner; do not attempt them inside a single-page task.

---

## 7. Final gate — the page's verdict

Assemble the layer results into one decision. Do not call the page done until:

1. **Every applicable layer has run and returned a gate result with evidence.** A layer that was skipped is recorded with a reason (e.g. "non-commerce → agentic-commerce N/A"; "single-language → hreflang N/A"). A silent skip is an oversight.
2. **No P0 failures remain in any layer.** A P0 fail anywhere (broken canonical, client-only price, invalid/dishonest schema, page≠feed) **blocks** the page — regardless of how strong the other layers are. P0s are fixed first.
3. **Site-level dependencies are flagged** (Section 6) with owners, so the page's verdict is honest about what a per-page pass does and does not guarantee.
4. **The human has the evidence to decide.** Present the assembled gate (per-layer P0 status + evidence + flagged sitewide items). The decision to publish is the human's (AI-assisted, human-led).
5. **Hand off measurement** — point to `ai-visibility-measurement-ritual` to verify the GEO effect after publish; don't keep re-tuning the page pre-publish past green.

**Verdict rule:** all applicable P0s pass (with evidence) → page is publishable; remaining P1/P2 logged as follow-ups. Any P0 fails → not ready. **Batch:** apply progressive sequencing — ship the pages that pass their P0s now, queue the rest; raise legibility iteratively rather than blocking the whole batch on one page.

---

## 8. Boundary cases

- **Truly single-layer request** ("just fix the title", "only add Product schema"): skip the orchestrator, call the one layer skill — unless the page is new or broadly broken, where the orchestrator's catch-the-forgotten-layer value applies.
- **Pure-utility page** (login, thank-you, internal tool): the orchestrator still runs, but most layers reduce to "correctly noindexed / minimal schema / no agent layer"; the technical layer's indexability item *inverts* (the goal is correct exclusion).
- **Non-commerce but lead-gen catalog** (enquire, made-to-order, import showcase): Q2 = yes in the "enquire" sense → run the agentic-commerce layer's discovery half, skip its checkout/protocol half (that skill's boundary case).
- **Page passes every layer but still isn't ranked/cited**: this is the site-level signal (Section 6) or an off-page/authority gap — escalate to sitewide work and `ai-visibility-measurement-ritual`, don't re-run page layers expecting a different result.
- **Conflicting layer guidance** (rare): if two layers' outputs seem to conflict, it is usually a boundary error (e.g. content marked up but not visible — a parity issue owned by `structured-data-discipline`). Resolve at the owning layer, not by overriding here.

---

## 9. Connections to other skills

- **`page-technical-seo`**, **`structured-data-discipline`**, **`agentic-commerce-readiness`**, **`geo-content-discipline`** — the four layers this skill routes to. Each owns its checklist and gate; this skill owns classification, sequencing, evidence assembly, and the final verdict. The boundaries between the four are defined in their own §8 cross-reference sections; this skill relies on those boundaries rather than restating them.
- **`ai-visibility-measurement-ritual`** — the read-side pair: this skill optimizes a page (write-side); that ritual measures whether AI surfaces cite it (read-side). The final gate hands off to it.
- **`series-design-discipline`** / **`prompt-writing-standard`** — when optimization decomposes into multiple Claude Code prompts (e.g. fixing several layers across several files), those skills govern how the prompts are written and sequenced; this skill decides *what* needs doing, they decide *how the prompts are built*.
- **`real-path-verification`** — "done means validated with evidence" (Sections 1, 7) is this skill's real-path verification: the assembled per-layer evidence is the verified real path.
- **`skill-writing-standard`** — built under that standard (outcome-based routing, third-person triggers, P0-first severity, classification-by-question instead of a brittle type table, honest page-vs-site framing, no duplication of the layer skills).

---

## 10. Changelog

- **2026-06-12 — v1.1.** §6 (site-level flag) hardened: the sitewide canonical/redirect/URL-planning item now explicitly calls out that on a URL change a 301 alone is not done — every inbound internal link across the site (catalog, cross-link blocks, nav, sitemap) must be repointed directly to the new URL, and since a page cannot see all links pointing to it, this inbound-link sweep is flagged as a site-level step. Points to `page-technical-seo` D2/D4 for the page-level half. No other sections changed.
- **2026-06-12 — v1.0.** Initial skill. Entry-door/router for the SEO+GEO optimization series: classify the page by question (intent/funnel, commerciality, detail-vs-listing, i18n) rather than a fixed type table; route to the four layer skills (page-technical-seo, structured-data-discipline, agentic-commerce-readiness, geo-content-discipline) deciding which apply and at what profile; sequence P0-first across layers; collect each layer's gate result with evidence without duplicating its checklist; flag page-level vs site-level dependencies honestly (domain trust, topic mesh, sitewide canonical/redirect, cross-platform consistency) as separate work; consolidated final gate with P0-first verdict and batch progressive sequencing; AI-assisted/human-led decision ownership; hand-off to measurement. Built from a 5×7 research pass (35 queries across 7 languages).
