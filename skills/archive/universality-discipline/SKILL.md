---
name: universality-discipline
description: Workflow standard that makes reuse of existing modules the default behavior over creating new ones. Use this skill whenever planning or writing a prompt that introduces any technical or design unit at any complexity level — from AI agents and search engines to UI components, from OCR pipelines to typography tokens, from contact forms to error toasts. Anything technical or design-related is treated as universal by default; non-universal status requires an explicit Vasily decision. This skill is mandatory in these situations — not optional. Do NOT use for pure content tasks (specific article text, single landing-page copy), documentation-only edits (knowledge/*.md, README), or infrastructure operations (deploy, restart, config edits).
---

# Universality Discipline
<!--
  @file:        skills/universality-discipline/SKILL.md
  @description: Default to reusing existing modules and patterns; create new only as explicit exception
  @version:     1.0
  @updated:     2026-05-19
-->

---

## 1. Philosophy

**Anything that already exists in this project is already integrated. Anything new is not.**

Existing modules — components, engines, tools, patterns, design tokens — have been calibrated against the rest of the system: design, error handling, logging, data flow, neighboring code. When something gets reused, the new place inherits that calibration for free. When something is built fresh, calibration starts from zero and almost always falls short — producing integration bugs, style drift, and duplicated logic that drift out of sync over time.

The default direction of reasoning is inverted: **reuse is the norm**, **create is the exception** that requires an explicit reason. This applies to anything technical or design-related, at any complexity — from large engines (AI agents, search backends, OCR pipelines, payment integrations) down to the smallest design tokens (a single padding value, a single icon, a single heading style).

**Two principles override everything else in this skill:**

1. **Universal by default** — anything technical or design-related is treated as universal unless Vasily explicitly declares otherwise. The registry grows automatically; entries are removed by command, not by inference.
2. **Adaptable by construction** — every universal is designed from the start to accept adaptation parameters (props, config, slots). A unit that cannot adapt is not a universal; it is a one-off masquerading as one. Such units must either be parametrized or removed from the registry.

---

## 2. Scope — What This Skill Covers

The skill covers **all** technical and design units at every complexity level. The following list is **illustrative, not exhaustive** — when in doubt whether something falls under this skill, the answer is yes.

### Large modules and engines
AI agents, search/analytics engines, OCR pipelines, authentication systems, payment integrations, parsers, schedulers, notification systems, billing engines, recommendation systems.

### Mid-level tools
Calculators, validators, formatters, exporters, error handlers, cache strategies, retry policies, log formats, rate limiters, queue processors.

### UI components
Buttons, forms, input fields, modals, tables, dropdowns, navigation, footers, page layouts, cards, lists, toasts, menus.

### Text patterns
Headings of a given type, error messages, placeholders, empty states, labels, legal notices, success messages, confirmation prompts.

### Design tokens
Colors, spacing values, typography scales, icon sets, animation curves, themes, shadows, border radii, breakpoints.

### Identity
Contact information, addresses, phone numbers, brand copy, support emails, social handles, legal entity names.

### Forms and lead capture
All data collection forms, contact blocks, signup forms, newsletter subscription, lead magnets, callback request forms.

### Out of scope (skill does not activate)

Three categories only:

1. **Pure content** — text of a specific article, description of one specific product, the body of one specific announcement. NOT "error message template" (that is a universal); only "the unique text of this one item".
2. **Documentation-only changes** — `knowledge/*.md` edits, README updates, ADR writing.
3. **Infrastructure operations** — deploy, restart, configuration edits, secret rotation, certificate renewal.

**Bugfix-via-replacement edge case:** if a bugfix would normally just patch an existing unit, but the right fix is to replace that unit with a universal module — the skill activates. The bugfix becomes a migration to a universal, with appropriate registry update.

---

## 3. Activation Triggers

This skill activates **automatically** when any of these observable signals appear:

### Trigger 1 — Task introduces a technical or design unit
The task description mentions creating, adding, building, or implementing anything that falls under §2 scope. Examples of phrasing: "Add a button for X", "Build a search interface", "Create a form for collecting Y", "Implement OCR for documents", "Set up the color palette", "Add the contact block to the footer".

### Trigger 2 — Task implies a technical or design unit
The task does not explicitly name a unit, but implementing it will require creating one. Example: "Add a checkout page" — a checkout page contains forms, buttons, error states, identity blocks. The skill activates at planning time, when these secondary creations become visible.

### Trigger 3 — Bugfix scope expands to replacement
A bugfix investigation concludes that the right fix is to replace the broken unit with a universal module from the registry (or create one if the universal doesn't exist yet).

### Trigger 4 — Explicit invocation
Vasily says "проверь универсалы", "посмотри что есть готового", "используй уже сделанное", "use existing", or any equivalent.

### Hard exclusions — skill does NOT activate

Only the three categories listed in §2 "Out of scope". For everything else, the skill activates. When in doubt, activate — the cost of checking the registry is one read; the cost of skipping a needed check is rework later.

---

## 4. Workflow Architecture — Three Layers

| Layer | Role | What they do |
|---|---|---|
| **Vasily** (decision layer) | Manager / visionary | Removes entries from universal status (the only way out); resolves "almost fits" calls; approves bootstrap scan; declares cross-project universals |
| **Claude — this chat** (reasoning layer) | Senior partner | Reads the registry; auto-registers new units; enforces both checkpoints; flags rigid (non-adaptable) units; surfaces analogs to Vasily |
| **Code Agent** (executor layer) | Coding agent | Receives prompts that already reference existing units and required adaptation parameters; uses them as instructed; does not invent parallels |

The discipline is enforced **on the planning side** (this chat) before any prompt is written. Claude Code receives prompts that already specify what to reuse, where it lives, and which adaptation parameters apply — removing the temptation to build new.

### Language of artifacts

| Artifact | Language | Reason |
|---|---|---|
| `knowledge/universals/*.md` entries | Russian or English depending on the project's existing knowledge convention | Match project's existing knowledge files |
| This skill's body | English | Repository artifact, per `prompt-writing-standard` §4 |
| Conversational reasoning with Vasily | Russian | Vasily's working language |

---

## 5. The Universals Registry — `knowledge/universals/` Folder

Every project has a `knowledge/universals/` folder. It is a mandatory artifact in the standard knowledge set (added to `knowledge-structure` skill §5 in a separate integration step).

### Purpose

A registry of every unit in the project that is reusable. The registry is the **first place** to look before building anything new. Because the scope is broad, a single file would become unmanageable — the registry is split by theme.

### Folder structure

```
knowledge/universals/
├── INDEX.md              # Lists all thematic files with one-line summaries
├── components.md         # UI components: buttons, forms, modals, navigation
├── design-tokens.md      # Colors, spacing, typography, icons, animations, themes
├── text-patterns.md      # Headings, toasts, errors, placeholders, empty states
├── identity.md           # Contacts, addresses, legal text, brand copy
├── tools.md              # Calculators, validators, formatters, parsers, handlers
├── engines.md            # Large modules: AI agents, search, OCR, auth, payments
└── forms-and-leads.md    # Data collection, contact blocks, lead capture
```

Thematic files may be added if a project develops a category that doesn't fit — for example, `email-templates.md` or `notifications.md`. The `INDEX.md` is updated whenever a thematic file is added.

### Entry format

Every thematic file follows the same table format:

```markdown
# Universals — Components — <Project Name>

<!--
  @file:        knowledge/universals/components.md
  @project:     <Project Name>
  @description: Reusable UI components
  @updated:     YYYY-MM-DD
  @version:     1.0
-->

| Unit | Lives at | Accepts (adaptation params) | When to use | When to deviate |
|---|---|---|---|---|
| PrimaryButton | src/components/ui/Button.tsx | label, onClick, variant ('default' / 'large'), disabled, loading | Any primary action | If destructive — use DestructiveButton |
| FormField | src/components/ui/FormField.tsx | label, name, type, placeholder, error, required | All form inputs | — |
| ... | ... | ... | ... | ... |
```

The **"Accepts" column is mandatory.** It lists the adaptation parameters of the universal. An empty "Accepts" column is a red flag — the unit may be rigid and not a real universal. See §7.

### How entries appear

Three ways an entry is created:

1. **Creation (default)** — every time a task creates a technical or design unit, an entry is added to the appropriate thematic file **immediately at creation**, not after second use. This is the **inverted default** of this skill: universal by default, not "earned" through repeated use.
2. **Bootstrap of existing project** — when this skill is first applied to a project that doesn't have `knowledge/universals/` yet, a one-time scan builds the initial registry. Claude reads `architecture.md`, scans `src/components/`, `src/lib/`, design configs. Everything that looks technical or design-related is added as a universal. Vasily reviews the result and **removes** entries that should not be universals (the only way out is by command).
3. **Explicit promotion** — Vasily declares "this is universal" or "this should be reused across all projects". For cross-project universals: the entry references `vibecoding-workspace/skills/external/REGISTRY.md` or a similar shared registry.

### How entries are removed

Entries are removed only when:
- **Vasily explicitly commands** removal: "убери X из универсалов", "это больше не универсал".
- The unit was deleted from the code.
- The unit was superseded; the entry's "When to use" column points at the successor.

**Removal is never inferred** by Claude from low-usage signals. Universal-by-default means the burden of removing is on explicit command, not on inference.

Removal is recorded in `knowledge/decisions/` as an ADR (per `knowledge-structure` §9 Content Preservation), not as a silent edit.

---

## 6. The Adaptability Requirement

**A universal that cannot adapt is not a universal.** Every entry in the registry must list its adaptation parameters in the "Accepts" column. Empty "Accepts" column = either fix the universal to accept parameters, or remove it from the registry.

### What "adaptable" means

A universal accepts at least one of these forms of parametrization, appropriate to its category:

- **UI component** — props for label/title, color/variant, size, disabled/loading states, onClick handlers, slot content.
- **Text pattern** — placeholders for variables, optional sections, tone variants (formal/casual).
- **Engine / tool** — config objects, dependency injection (which model, which DB, which logger), behavior switches.
- **Design token** — scale variants (sm/md/lg), semantic role (primary/secondary/danger).
- **Form** — field configuration, validation rules, submit handler, success/error callbacks.

### What it does NOT mean

- A universal does not have to handle every possible case. It has to handle the **common** cases via parameters; legitimate boundary cases (§8) get their own universal.
- "Adaptable" does not mean "infinitely configurable". A universal with 30 props for hypothetical futures is bad design. Parametrize what is actually needed; extend later by adding props.

### When extending a universal for a new case

The default is **parametrize**, not fork:
- New case needs different padding → add `padding` prop, not create `PaddedButton`.
- New case needs different copy → add `label` prop, not create `LongTextButton`.
- New case needs different color → add `variant` prop, not create `BlueButton`.

Forking is permitted only under §8 boundary cases.

---

## 7. The Discipline — Two Checkpoints

The skill runs at two points in the workflow.

### Checkpoint 1 — During plan formulation (Step 7 of `prompt-writing-standard`)

When writing the plan for Vasily's approval:

1. Open the relevant files in `knowledge/universals/` based on the task's scope.
2. For each technical or design unit the task will create or affect, find its category and search for an analog.
3. **If an analog exists:** in the plan write *"Use existing X from `universals/<file>.md`. Adaptation via parameters: [list]."*
4. **If no analog exists:** in the plan write *"No analog in registry. Creating new universal. Will add entry to `universals/<file>.md` with adaptation parameters: [list]."*
5. **If "almost fits":** STOP. Do not resolve in plan. Ask Vasily: extend existing via parameters, or create a parallel universal?

The plan presented to Vasily **explicitly states reuse decisions** for every candidate unit. Silent invention is forbidden.

### Checkpoint 2 — Right before writing the prompt (Step 8b of `prompt-writing-standard`)

Just before writing the Claude Code prompt:

1. Re-read the relevant `universals/*.md` files — they may have been updated since the plan was approved.
2. If a new analog appeared, adjust the prompt to use it. If Vasily objects to the adjustment, escalate.
3. In the prompt's **CONTEXT block**, list referenced universals: *"Reuses: `PrimaryButton` from `universals/components.md`; `API error wrapper` from `universals/tools.md`."*
4. In the prompt's **REGRESSION SHIELD block**, add: *"Do not create parallel variants of registered universals. Extensions are done via parameters, not new units. Adding a new universal requires a separate prompt with explicit registry update."*
5. If the prompt creates a new universal, in the **ACCEPTANCE CRITERIA block** add a checkbox: *"Entry added to `knowledge/universals/<file>.md` with file path and adaptation parameters listed."*

---

## 8. Boundary Cases — When Creating a Parallel Universal Is Right

This skill is reuse-first, not reuse-always. Three legitimate cases for creating a parallel universal. All three require an explicit reason stated in the plan.

### Case 1 — Fundamentally different responsibility

The existing universal's responsibility does not include the new case in any reasonable extension. Example: `ErrorToast` shows user-facing errors; a new internal admin diagnostic indicator is conceptually distinct. Build a separate universal (`AdminDiagnosticBadge`).

**Test:** would a developer who knows the existing universal be surprised seeing it do the new thing? If yes — separate universal.

### Case 2 — Parametrization is impossible

Extension via parameters would require removing or weakening an invariant other call sites rely on. Example: `PrimaryButton` is keyboard-accessible by design; the new case is a decorative ghost button with no keyboard handling. Adding a `ghostMode` prop that disables accessibility damages the existing contract.

**Test:** does the extension require removing or weakening a property other callers rely on? If yes — separate universal.

### Case 3 — Explicit Vasily decision

Vasily said: "здесь хочу другую кнопку, не существующую" / "use a different engine here, not the existing one". Explicit user intent overrides default. In the plan: *"Vasily requested non-standard variant; existing X not used. Reason: [stated]."*

In all three cases, **the new universal is registered immediately** in the appropriate `universals/<file>.md` — future tasks may reuse it.

---

## 9. Anti-patterns — Explicitly Forbidden

If the model catches itself doing any of these — stop, back up to Checkpoint 1.

1. **Silent parallel variant** — building an analog without checking the registry. "I'll just write a button real quick" is the canonical failure.
2. **"Almost fits" resolved alone** — concluding "existing X almost fits, I'll fork it" without escalating to Vasily.
3. **Rigid universal without adaptation parameters** — a copy bound to one place, masquerading as a universal. Empty "Accepts" column.
4. **Cosmetic difference as justification** — "needs slightly different padding/color/animation" → that is a `padding` / `color` / `animation` prop on the existing universal, not a new variant.
5. **Treating the registry as documentation, not contract** — the registry is binding. A registered entry must be used unless §8 boundary cases apply with stated reason.
6. **Skipping Checkpoint 2 because Checkpoint 1 passed** — the registry may have been updated by other work in progress. Re-check before writing the prompt.
7. **Failing to register a newly created universal** — every new technical/design unit gets an immediate registry entry. No delayed registration.
8. **Inferring removal from registry without Vasily command** — universals stay in the registry until Vasily explicitly removes them.
9. **Letting Code Agent decide reuse-vs-create on its own** — the discipline is enforced before the prompt is written. Claude Code receives prompts that already specify what to reuse and where, with adaptation parameters listed.
10. **Stretching parameters to absurdity** — if a single universal has 30 props for every hypothetical case, that is bad design, not adaptability. Trim back; consider whether one of the cases is a legitimate §8 boundary that deserves its own universal.

---

## 10. Connections to Other Skills

These integrations are implemented as a **separate step** after this skill's commit. They are listed here for traceability.

- **`prompt-writing-standard`** — plugs into §2 Step 7 (plan formulation) and Step 8b (just before writing the prompt). The CONTEXT, REGRESSION SHIELD, and ACCEPTANCE CRITERIA blocks of every applicable prompt reference reuse decisions and adaptation parameters explicitly.
- **`knowledge-structure`** — `knowledge/universals/` becomes a mandatory artifact in §5 Standard File Set. Bootstrap mode is invoked on first session with any project that doesn't have the folder yet.
- **`code-markup-standard`** — new inline operational tag `@universal: <registry-entry-link>` added to file headers of universal modules. This makes the universal status traceable from the code side, not only from the registry.
- **`bug-hunting`** — when a recurring bug turns out to be "two copies of the same logic drifted out of sync", that is a universals-discipline failure. The fix consolidates to one universal with appropriate parameters and registers it (if not already registered).
- **`research-protocol`** — when a research decision produces a recommendation that is a candidate universal (e.g. "use X engine for all payment flows across projects"), the resulting ADR includes a registration action.

---

## 11. Quick Reference

| When | Do |
|---|---|
| Plan a task that creates any technical or design unit | Read relevant `universals/*.md`, find or note absence of analog, state in plan |
| Plan says "use existing X" | In prompt CONTEXT: `Reuses: X (universals/<file>.md)`, list adaptation params |
| Plan says "no analog, create new" | Create with mandatory adaptation parameters; register in `universals/<file>.md` immediately |
| Existing universal "almost fits" | STOP — escalate to Vasily, do not resolve silently |
| Need a variant for a new case | Default: add a parameter to the existing universal, do not fork |
| Three §8 boundary cases met | Create parallel universal; register both immediately |
| Project has no `knowledge/universals/` yet | Bootstrap: scan codebase, draft full registry, get Vasily's review of what to **remove** from universal status |

| Don't | Do |
|---|---|
| Build silently parallel to existing | Read registry first |
| Wait for "second use" before registering | Register at first creation |
| Resolve "almost fits" alone | Ask Vasily |
| Leave "Accepts" column empty | Specify adaptation parameters — empty = not a universal |
| Skip Checkpoint 2 because plan was approved | Re-check registry right before writing the prompt |
| Cosmetic difference → new variant | Cosmetic difference → new parameter on existing universal |
| Remove universal status by inference | Remove only on explicit Vasily command |
