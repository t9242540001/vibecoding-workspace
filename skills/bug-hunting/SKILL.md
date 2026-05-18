---
name: bug-hunting
description: Systematic protocol for finding and fixing bugs through hypothesis-driven debugging. Use this skill whenever a bug fix has failed twice with the same approach, when Vasily explicitly says he cannot find a bug, when the same bug keeps coming back in the chat, when a previously fixed bug has returned, or when handling a production incident. This skill is mandatory in these situations — not optional.
---

# Bug Hunting
<!--
  @file:        skills/bug-hunting/SKILL.md
  @description: Systematic protocol for finding and fixing bugs
  @version:     2.0.1
  @updated:     2026-04-17
-->

---

## 1. Philosophy

**Discipline beats intuition. Symptom is not cause. Workaround is not solution.**

Hours of bug-hunting are rarely caused by the bug being hard. They are caused by the absence of process: jumping between hypotheses without writing them down, fixing several things at once, trusting intuition over data, googling the symptom before reading the actual logs.

This skill exists to replace that with a structured protocol — borrowing from Agans's *9 Indispensable Rules*, Spinellis's *Effective Debugging*, Zeller's *Why Programs Fail*, hypothesis-driven debugging from Google SRE, and the bisection / inflection-point methods.

---

## 1.5. Workflow Architecture — Three Layers

This skill operates in a three-layer architecture. Every action in Phases 1–4 must be understood as belonging to one of these layers:

| Layer | Role | What they do |
|---|---|---|
| **Vasily** (decision layer) | Manager / visionary | Approves plans, copies prompts to Claude Code, executes commands that require interactive input or sudo, confirms deploys, validates fixes |
| **Claude — this chat** (reasoning layer) | Senior technical partner | Investigates autonomously via MCP tools, forms hypotheses, generates prompts for Claude Code, maintains the investigation log, makes recommendations |
| **Claude Code** (executor layer) | Coding agent | Reads/writes repository files, runs tests, makes commits — strictly via prompts following `prompt-writing-standard` |
| **VDS / production** | Target environment | Reached primarily by Claude through MCP file connectors; reached by Vasily when MCP cannot |

### Autonomy principle

**Claude does the work. Vasily approves, copies, executes commands that require him.**

Claude must attempt the task as autonomously as possible by using available tools before requesting Vasily's involvement:

- **Files in the repository** → read via `JCK AUTO Files` / `VDS Files` MCP, do not ask Vasily to paste file contents
- **Knowledge base lookups** → use `AI Knowledge Base` MCP and read `knowledge/INDEX.md` + relevant files directly
- **Server-side files and logs** → read via `VDS Files` MCP wherever possible (log files, config files, databases via file access)
- **Past similar bugs** → use `conversation_search` proactively before asking Vasily "do you remember"
- **Web search** → use `web_search` when investigating known errors in dependencies or framework patterns

Claude turns to Vasily only when:
- The required action requires Vasily's authority (deploy, rollback in production, payment-related changes)
- The required action requires interactive input that MCP cannot perform (`sudo` prompts, SSH key passphrases, TUI applications)
- The data is genuinely outside MCP reach (a screenshot of a third-party UI, a phone notification, a user report received through another channel)
- Read access via MCP fails or returns errors that Vasily must diagnose

When Claude does ask Vasily for something, the request is specific: exact command to run, exact file to look at, exact question to answer. Never a vague "please check the logs".

### Language of artifacts

| Artifact | Language | Reason |
|---|---|---|
| Phase 1 framing summary, investigation log, conversation responses | Russian | Vasily's working language; these are read in chat |
| Prompts for Claude Code, RULE comments in code, `decisions.md` entries, `rules.md` entries | English | Per `prompt-writing-standard` Section 4 — repository artifacts stay in English |
| Knowledge file headers and content | Mixed per file's purpose | Per `knowledge-structure` rules |

---

## 2. Activation Triggers

This skill is **mandatory** when any of the following observable signals appear. Claude switches to bug-hunting mode unilaterally upon detecting any of them, and informs Vasily explicitly: "Перехожу в режим bug-hunting по триггеру X — далее по протоколу."

### Trigger 1 — Two failed fix attempts on the same bug

Two prompts have been sent to Claude Code with the intention of fixing the same bug, and after both, the bug still reproduces by the original scenario. The third prompt addressing the same bug MUST be preceded by activating this skill — regardless of how confident the next approach feels. This matches the system instruction's "third attempt with same method is ineffective" rule.

### Trigger 2 — Conversation signals of stuck debugging

- 5+ messages in the current chat are about the same bug without finding the root cause
- Vasily writes time-pressure phrases ("долго ищу", "не могу найти", "уже час сижу", "пятый раз пробую", "что-то не так")
- The same error reappears in the chat after a recent fix prompt was supposedly successful

### Trigger 3 — Explicit invocation

Vasily says "let's debug this systematically", "ищем баг", "нужен bug hunt", or any equivalent.

### Trigger 4 — Production incident

A live incident in production — even on the first attempt. High stakes warrant the discipline. Triage immediately per Section 2.5.

### Trigger 5 — Recurrence of a previously fixed bug

A bug that was previously closed has returned. This means the previous fix addressed a symptom, not the cause. Full bug hunt is mandatory — no quick attempts.

---

## 2.5. Severity Triage — First Step After Activation

Before entering Phase 1, classify severity. Severity determines whether the protocol runs in normal mode or in **Emergency Mode** (mitigation first, full investigation after).

| Severity | Recognition | Mode |
|---|---|---|
| **SEV-1 (incident)** | Production is down, critical function broken, users actively suffering, money or data at risk | **Emergency Mode** — see below |
| **SEV-2 (urgent bug)** | Production runs, but bug affects significant functionality or a known user is blocked | Normal mode, all phases |
| **SEV-3 (regular bug)** | Local problem, does not block users, can wait | Normal mode, may span multiple sessions |

### Emergency Mode (SEV-1 only)

Per Google SRE's incident response: **first responders prioritize mitigation above all else**. The bug hunt does not start with "forbidden to touch code" — it starts with restoring service.

Emergency Mode is a 5–15 minute mini-protocol:

1. **Mitigate immediately.** Apply the fastest available restoration: rollback to last working commit, disable the affected feature flag, scale up resources, drain traffic. Action without full understanding is acceptable here.
2. **Verify mitigation worked.** Confirm via observability (logs, status check, smoke test) that user impact has stopped.
3. **Record the mitigation in `decisions.md`** with the format from Section 6.2 (mitigation block) — explicitly marked as ACTIVE MITIGATION, not a fix.
4. **Switch to normal mode.** Once stable, restart from Phase 1 of the standard protocol to find and apply the real fix. Without this step, the bug returns.

The bug hunt is not closed by mitigation. Mitigation is a tourniquet, not surgery.

---

## 2.6. Lightweight Mode — For Obvious Tactical Errors

Not every failed fix deserves the full protocol. If after the first failed fix the cause is mechanically obvious (typo in a variable name, wrong import path, missed null check now visible in the diff) — Claude may apply Lightweight Mode.

**Conditions (all must be true):**
- The fix is mechanical, not conceptual
- The original cause is visible in the failed fix's diff or error trace
- No production impact
- Vasily explicitly accepts Lightweight Mode for this case ("давай по-быстрому", "очевидно же, поправь")

**In Lightweight Mode:**
- Skip Phase 1 (framing) and Phase 2 (reproduction)
- Send a corrected fix prompt directly via `prompt-writing-standard`
- Still record in `decisions.md` if the bug touched a project rule or non-trivial behavior

**If the second attempt also fails — Lightweight Mode is automatically revoked.** Full bug-hunting protocol activates per Trigger 1, no further shortcuts.

---

## 3. Phase 1 — STOP & FRAME

**Goal:** do not start digging until you understand what you are digging for.

**Forbidden in this phase:** writing fix prompts, executing tactical changes, googling the error message before reading it carefully.

### Self-directed questions

Answer all of these explicitly before moving on. If any answer is "I don't know" — that is the first thing to find out, not assume. Claude attempts to answer each question autonomously via MCP tools before turning to Vasily.

- What exactly broke? State the symptom in one sentence — what the user sees vs what they expected.
- When did it last work? (sets the time boundary for bisection) — Claude can check via `git log` through file MCP.
- What changed since then? Commits, configs, env vars, dependencies, data, external services. Claude reads `git log`, recent commit diffs, deploy history via MCP.
- What do I expect to see vs what I actually see? The gap defines the size of the problem.
- Is this a new bug or a recurring one?
  - **Claude proactively runs `conversation_search`** with keywords from the symptom (error message fragment, file name, symptom description) before asking Vasily. Past investigations of similar bugs are highly relevant — they may contain the answer or rule out hypotheses cheaply.
  - **Claude reads `knowledge/decisions.md`** via file MCP to check for previous occurrences of this symptom or related ones.
- Does this match any pattern in `knowledge/rules.md` or any `RULE:` comment in the affected files? Claude reads via MCP.

### Virtual team — pull in the right specialists

Based on the symptom, identify 1–3 relevant specialists from the project's virtual team roster (per the system instruction). Each specialist contributes one perspective during Phase 3 hypothesis generation.

| Bug type | Specialists |
|---|---|
| Network / API errors | DevOps + Security |
| UI breakage | UX-analyst + Frontend |
| Auth / session issues | Security + Backend |
| Performance degradation | DevOps + Architect |
| Data corruption / wrong values | Architect + relevant domain expert |
| File processing / generation (PDF, images, exports) | Architect + domain expert (the file's domain) |
| LLM integration / AI output quality | Prompt-engineer + relevant domain expert |
| Cron / scheduled jobs | DevOps + Backend |
| Email / notifications | DevOps + UX (for triggers) or Copywriter (for content) |
| Bot interactions (Telegram, etc.) | Backend + UX + Copywriter (if about texts) |
| Other / unclear | Architect + relevant domain (Vasily decides if unclear) |

### Output of Phase 1

A short framing summary in Russian:
```
### Симптом
[одно предложение]

### Последняя рабочая версия
[дата / коммит / время]

### Что изменилось
[список из git log и других источников]

### Похожие случаи
[ссылки на decisions.md, rules.md, прошлые чаты из conversation_search, или "не найдено"]

### Подключённые специалисты
[список ролей]
```

Only after this — proceed to Phase 2.

---

## 4. Phase 2 — REPRODUCE

**Goal:** have a reliable way to trigger the bug on demand. Without this, every "fix" is blind.

### Branch A — Bug reproduces deterministically

- Document minimal steps. Stop minimizing when (a) further reduction would lose the bug's distinguishing features, or (b) you've spent more than 15 minutes minimizing. The goal is reliable triggering, not perfect minimalism.
- Document required data state.
- Confirm: does it reproduce locally / on staging / in prod? Claude can check files and logs across environments via MCP.

### Branch B — Bug is intermittent (heisenbug)

If the bug doesn't reproduce reliably:

- Run the failing scenario N times (typically 20–100), record success/failure ratio. For server-side bugs Claude can request Vasily to run a loop, or write a small reproduction script as a Claude Code prompt.
- This gives a measurable baseline — "fails 30% of the time" is reproducibility, just statistical.
- **Heuristic: intermittent bugs are almost always one of:**
  - Race condition (concurrent access, ordering)
  - State leak (shared mutable state between runs)
  - External dependency variability (network latency, third-party API behavior)
  - Timing-dependent code (timeouts, retries, scheduled tasks)

**Strategy for Phase 3 based on failure rate:**
- **Failure rate > 50%** — investigate as if deterministic; the heisenbug is consistent enough to follow normal hypothesis testing
- **Failure rate 5–50%** — focus hypotheses on race conditions, ordering, state leaks; collect logs from both successful and failed runs to compare differences
- **Failure rate < 5%** — almost certainly external dependency (network flake, third-party API). Investigate retry logic, timeouts, and the dependency's status page

After applying the fix, re-measure with the same N runs. Expected: zero failures.

### Branch C — Bug only reproduces in production

If you cannot reproduce locally or on staging, **do not force local reproduction** — switch to observability mode:

- Add structured logging with correlation IDs at the suspected paths (delivered as a Claude Code prompt, deployed, then logs read back via VDS Files MCP)
- Capture full request/response context for affected requests
- Build statistics from logs: when does it fire (time of day, load, specific users, specific data)
- **Read-only access to production data — never write or experiment in prod via MCP, only read.** Any changes go through a Claude Code prompt and Vasily-approved deploy.

In observability mode, "reproduction" means having enough captured evidence to walk through what happened. Move to Phase 3 only when you have that evidence.

### Blocking rule

Without reproduction (deterministic, statistical, or observability-based) — **do not proceed to Phase 3**. Fixing without reproduction is gambling.

---

## 5. Phase 3 — INVESTIGATE (cyclic)

This is the core of the skill. The cycle repeats until root cause is found.

### 5.1. Data search algorithm — where to look, in what order

Cheap and informative first. Don't read code until you've read the error. Don't google until you've formed your own hypothesis. **Claude executes each step autonomously via MCP wherever possible**, asking Vasily only when the source is genuinely outside MCP reach.

| # | Source | Why this position | How Claude accesses it |
|---|---|---|---|
| 1 | Full error message + stack trace | Often contains the answer. Read in full, never paraphrased. | Read from logs via VDS Files MCP, or from chat if Vasily already pasted it |
| 1.5 | **Environment sanity check** (see below) | First class of "pseudo-bugs" in vibe-coding. | MCP read of `.env` (without leaking secrets to chat), `package.json`, lockfiles, version files |
| 2 | `knowledge/decisions.md`, `knowledge/rules.md` | Has this happened before? Most under-used source. | Read via file MCP — JCK AUTO Files or VDS Files |
| 3 | Recent commits (`git log --since="last working time"`) | What changed since it worked. | Read git history via file MCP (read `.git/logs/HEAD` or pre-existing log files) |
| 4 | Server logs (`pm2 logs`, `journalctl`, application log files) | Reality of what the system did. | Read log files directly via VDS Files MCP. If a live `pm2 logs` stream is needed — request Vasily to run and paste the relevant window. |
| 5 | DevTools — Console + Network | For frontend and API bugs, the truth is here. | Request Vasily to provide screenshots or copy console output (genuinely outside MCP reach) |
| 6 | Database state | Is the data what the code thinks it is? | Read DB via MCP if file-based DB; otherwise request Vasily to run specific SQL and paste result |
| 6a | **Walk through the failing input manually** | For data-processing bugs: trace one specific failing input through the code mentally, or have Claude Code add temporary logging at each transformation step | Combination of Claude reading code via MCP and writing a logging prompt |
| 7 | Configs and env vars | What differs from a working environment? | Read config files via MCP; compare environments |
| 8 | Code reading around the failure point | Only after facts above — context, not blind exploration. | Read code via file MCP |
| 9 | Internet search | After you have a hypothesis, not instead of it. (See exception below.) | `web_search` tool |
| 10 | Dependency / library docs and **GitHub issue tracker** | If suspicion points at a dependency, search the library's open and recently closed issues for the exact error message *before* assuming your code is at fault. Many vibe-coding bugs are known issues — solution is usually a version bump or documented workaround. | `web_search` with site filter |

**Principle:** if you find yourself reading code (step 8) before reading logs (step 4), stop and back up. The order is not arbitrary — it is calibrated by cost and information value.

**Adaptation:** if a source is not available in this project (no `pm2`, no `journalctl`, no DevTools because it's a backend service, no git history because the project is fresh) — skip the source and document the absence in the investigation log: "Source X unavailable, skipping". The order is a priority guide, not a blocking sequence.

**Exception to the "no early googling" rule:** when the error message is clearly a typed framework/library error (`ECONNREFUSED`, `CORS policy: ...`, `TypeError: Cannot read property X of undefined` from a known library), an early search is allowed and often informative — these have well-documented causes. The general rule remains: don't replace your own reasoning with search; supplement it.

#### Environment sanity check (step 1.5 expanded)

For any bug that "worked yesterday and broke today" or "works on staging, breaks locally" — run this checklist before deeper investigation:

- Versions match production (node, python, etc.)?
- All env variables present and loaded? (Check by name, never log values)
- Dependencies installed and matching `package.json` / `requirements.txt`?
- DB migrations applied?
- Browser cache cleared / incognito mode tried (for frontend)?
- Correct project / branch in Claude Code (per system instruction reminder)?

Skipping this can mean spending hours debugging code that wasn't actually broken. **Heuristic: if the error message is bizarre or contradicts what the code obviously does — environment check before code reading.**

### 5.2. Generate cause hypotheses — minimum 3, never one

One hypothesis = confirmation bias guaranteed. Always generate at least three, including ones you don't believe.

**Note on terminology:** *cause hypotheses* (Phase 3) are guesses about *why* the bug exists. *Solution variants* (Phase 4, when applicable) are different *ways to fix* an identified cause — those are required when the same fix has failed twice (per the system instruction's repeated-errors protocol), not at the cause-hypothesis stage.

Each cause hypothesis in this format:
```
H1: [what is suspected to be broken]
If H1 is true → we should observe [specific testable indicator]
If H1 is FALSE → we should observe [opposite indicator]
Cost to test: [low / medium / high]
How tested: [Claude reads file X / Claude writes Claude Code prompt to add logging / Vasily runs command Y / etc.]
```

The "if false" condition is critical — without it, the hypothesis is unfalsifiable, which means it teaches you nothing whether it confirms or not.

### 5.3. Rank hypotheses

Combine two factors:
- **Likelihood** based on the suspicion hierarchy below
- **Cost to test** — start with cheapest

**Suspicion hierarchy (statistical — what breaks most often):**
1. What changed last (recent commits, recent config changes, recent deploys)
2. Boundaries between components (your code ↔ library ↔ external service)
3. Edge cases in data (null, empty, very large, non-ASCII, timezone, encoding)
4. Race conditions / execution order
5. Configuration / env vars
6. "Deep" business logic — last, statistically the rarest cause

### 5.4. Bisection — when applicable

If a working version exists in the past — use `git bisect` (or manual binary search). Most efficient tool against regressions, often skipped because it feels mechanical.

In Vasily's workflow, bisection is delivered as a Claude Code prompt: "Perform git bisect between commit X (known good) and HEAD (known bad), testing with [reproduction command from Phase 2]. Report the first bad commit." Claude formulates the prompt and explains the bisect concept; Claude Code executes; Vasily approves and forwards results. Logarithmic search — even 1000 commits collapses to 10 tests.

### 5.5. Change one thing at a time (Agans Rule #5)

If you change two things and the bug disappears, you don't know which change helped. The "fix" may unravel an hour later because the second change was masking a third problem. Each Claude Code prompt changes one thing.

### 5.6. Investigation log — Claude maintains it inline in the chat

Claude maintains the investigation log in the chat in real time, in this format:
```
## Bug Hunt — [short title]

### Symptom
...

### Reproduction
...

### Hypothesis log
- [step number] H1: [hypothesis] — tested by [method] — RESULT: refuted because [data]
- [step number] H2: [hypothesis] — tested by [method] — RESULT: confirmed
```

After 2 hours of debugging Vasily forgets which hypotheses were ruled out. The log prevents going in circles. It also becomes the basis for the `decisions.md` entry in Phase 4.

### 5.7. Debugging LLM Output Quality — different protocol

If the bug is poor output from an LLM (wrong tone, missed instructions, hallucination, format errors) — this is debugging the *prompt*, not the *code*. Different protocol applies:

1. Capture the full input: system prompt + user message + any tool results (the actual chat that produced the bad output, not a paraphrase)
2. Identify which instruction was violated or missing
3. Hypothesize: was the instruction unclear, contradicted by another instruction, or absent entirely?
4. Test the hypothesis by modifying just that instruction and rerunning the same input
5. The fix is a prompt edit (per `prompt-writing-standard`), not a code change

Apply standard `bug-hunting` discipline: minimum 3 cause hypotheses, document refuted ones, etc. — but the artifacts are prompts, not code.

---

## 6. Phase 4 — CONCLUDE & FIX

### 6.1. Root cause vs symptom — verification

Self-check: **"If I remove this cause, will the bug disappear with certainty?"**

If the answer is "probably" or "I think so" — this is not the root cause. Keep digging.

Apply Five Whys with discipline: ask "why did that happen?" five times in a row. The first three usually land at the symptom. The fourth and fifth land at the systemic cause. Stop only when "why" no longer produces a new answer.

**Caveat on Five Whys:** the method has known weaknesses — it can drift toward blame ("why did the developer not check") and different facilitators may reach different root causes from the same incident. **Mitigation:** each "why" must point at a *system property*, not a person. If "why" answers with a person's action, the next "why" must ask why the system allowed that action. Stop when you reach a system property that, if changed, would prevent the bug class — not just this instance.

### 6.2. No workarounds, no temporary solutions

A "temporary solution" is technical debt. If a fix does not resolve the root cause, it is not accepted as the fix.

**Allowed:**
- **Production mitigation** (rollback, feature flag, cache disable) — used while the real cause is being investigated, but explicitly labeled as mitigation, not a fix. See mitigation procedure below.
- **Real fix** — the only acceptable conclusion to a bug hunt

**Forbidden:**
- `try/except` (or equivalent) without logic, masking the error
- Conditions like `if x is None: x = default` without understanding why x became None
- Hardcoding a value instead of fixing the logic that computes it
- "Changed the order and it worked" without understanding why
- Adding a retry loop to mask a race condition instead of fixing the race
- Increasing a timeout to mask slow code instead of fixing the slowness

#### Mitigation procedure (when used)

If mitigation is applied (rollback, feature flag, etc.) — the bug hunt does NOT close until the real fix is applied. Mitigation entry in `decisions.md` uses this format:

```
## YYYY-MM-DD — Mitigation: [short title]
**Status:** ACTIVE MITIGATION — root cause investigation pending
**Mitigation applied:** [what was done]
**Symptom suppressed:** [what user-visible problem stopped]
**Root cause:** unknown / under investigation
**@todo:** complete bug hunt and apply real fix; remove mitigation
```

An active mitigation is technical debt with a counter — it must be cleared. Track active mitigations in `roadmap.md` until cleared.

If a real fix is not possible right now (e.g. requires a library upgrade, schema migration, or vendor response) — apply mitigation, document the gap with a clear plan, and do not pretend the bug is fixed.

### 6.3. Check the fix against neighboring code

Before declaring done, run a multi-perspective check on the fix itself (parallel to `prompt-writing-standard` Step 9):

- **Stakeholder:** does the fix actually solve the user-visible problem?
- **Technical:** did the fix break any neighboring functionality? Does it violate any `@rule` or `RULE:` comment in the affected files? Does it conflict with `decisions.md` entries?
- **Domain expert:** does the fix violate any domain rule (e.g. legal, financial, security) that's relevant to the affected code?

This check is *complementary* to the REGRESSION SHIELD block inside the fix prompt (per `prompt-writing-standard` Section 3). The shield prevents Claude Code from breaking neighbors *during* the fix; this check verifies *after* execution that nothing actually broke. Both are mandatory, neither replaces the other.

If the fix needs follow-up changes elsewhere, those become separate prompts — never bundled into the fix prompt.

### 6.4. What to record in knowledge

This section specifies *what content* goes into `decisions.md`. The actual update happens inside the fix prompt itself, via the knowledge-AC checkbox required by `prompt-writing-standard` Section 4 ("Knowledge update rule"). This is not a separate update step — it is the content specification for that AC item.

The `decisions.md` entry must contain:
- What happened (symptom)
- What was the actual root cause
- What hypotheses were considered and ruled out (this is not noise — it's a map for the next similar bug)
- What was changed to fix it

This entry is what makes Phase 1 (checking decisions.md) valuable for the next bug. Without it, the project keeps re-discovering the same bugs.

### 6.5. Regression test — when required

Regression test is required when ANY of the following is true:
- The bug took more than 3 fix attempts to resolve
- The bug recurred after a previous fix (you're now fixing it for the second time)
- The bug was in code that handles money, auth, user data, or any compliance-relevant logic
- The bug was production-impacting (SEV-1 or SEV-2)

Not required for trivial bugs (typo, missed semicolon, obvious off-by-one).

The test should reproduce the bug as documented in Phase 2 — and pass after the fix. Test creation is delivered as a separate Claude Code prompt (see Section 8 — sequence of prompts).

### 6.6. RULE anchor in code

Add a `RULE:` comment next to the vulnerable code (per `code-markup-standard` Section 8). The anchor is the anti-regression mechanism at the code level — Claude Code sees it on every future edit.

Format example:
```
// RULE: <rule statement>
// <Why this matters / what breaks if violated. Reference decisions.md entry date.>
```

### 6.7. Closure — when the bug hunt is officially done

A bug hunt is **closed** when ALL of the following are true:

1. The fix prompt has been executed by Claude Code and merged
2. Vasily has deployed the fix and confirmed the bug no longer reproduces in the relevant environment
3. For statistical bugs — failure rate is now zero (run the same N times)
4. Smoke test of neighboring functionality passes
5. `decisions.md` entry has been added (per Section 6.4)
6. `RULE:` anchor added (if applicable per Section 6.6)
7. Regression test added (if Section 6.5 applies)
8. Knowledge integrity check (per `knowledge-structure` Section 13) passes

Until all eight are true, the bug hunt is still open. "Code merged" alone is not closure.

If the bug hunt is one of multiple tasks in a session — run the integrity check after this bug hunt closes, not at the end of session. Multiple integrity checks per session are fine; missing one is not.

### 6.8. Class prevention — optional but recommended

After fixing — ask one question: **"How can a *class* of bugs like this be prevented?"**

Possible class-prevention measures:
- **Type system / validation** — adding types or runtime validation at a boundary
- **Linter rule** — automating detection of the pattern
- **Architecture change** — eliminating the possibility (e.g. making a state machine illegal-state-unrepresentable)
- **Documentation** — adding a rule to `rules.md` so future bugs of this class are caught earlier in code review

Class prevention is optional but recommended for bugs that took significant investigation. Document the chosen prevention measure (or "no class prevention warranted, reason: ...") in `decisions.md` alongside the bug entry.

---

## 7. Anti-patterns — explicitly forbidden

The skill exists to prevent these. If Claude catches itself doing any of them — stop, back up to the relevant phase.

1. **Shotgun debugging** — changing many places at once, hoping one fix sticks
2. **Stack Overflow first** — googling the error before reading your own logs (with the typed-framework-error exception from Section 5.1)
3. **"It should work"** — arguing with reality based on theory
4. **Silent edit** — fixing without recording in `decisions.md`
5. **Skipping reproduction** — "I get it, let's fix it" → blind fix
6. **One hypothesis** — pure confirmation bias
7. **Trusting paraphrased logs** — "there was something about timeout" is not data; raw logs are
8. **Workarounds** — try/except wrapping, default-on-null, hardcoded values, masking retries, inflated timeouts (see Section 6.2 for full list)
9. **Accepting fix without checking neighboring code** for regressions (Section 6.3)
10. **"It's faster this way"** — speed is not justification for skipping the protocol during a bug hunt; skipping the protocol is exactly why hours get burned
11. **Asking Vasily to do MCP-accessible work** — if the file or log can be read via MCP, Claude reads it and does not ask Vasily to paste it (per Section 1.5 autonomy principle)

---

## 8. Connections to Other Skills — Sequence of Prompts

A bug hunt produces a sequence of prompts, executed and confirmed in this order. Each prompt is self-contained and follows `prompt-writing-standard` (4-block template, multi-perspective Step 9 review, etc.). The next prompt is sent only after the previous one has been confirmed complete by Vasily. This is consistent with `prompt-writing-standard` Section 6 (one prompt = one file) — not an exception to it.

### Prompt 1 (mandatory) — The fix itself

Targets the file containing the root cause. Includes RULE anchor (per `code-markup-standard` Section 8). Updates the file's `@updated` and (if needed) `@version`. The CONTEXT and TASK content for this prompt is produced by Phases 1–3 of this skill.

### Prompt 2 (mandatory if root cause was non-trivial) — Knowledge update

Updates `decisions.md` with the entry described in Section 6.4. May also update `rules.md` if a new rule was discovered. Per `knowledge-structure` rules — including the Content Preservation Rule (Section 9) and Anti-Duplication Rule (Section 11).

### Prompt 3 (mandatory if Section 6.5 applies) — Regression test

Adds a test that reproduces the bug as documented in Phase 2 — and passes after the fix.

### Skill cross-references

- **`prompt-writing-standard`** — every prompt in the sequence above follows that standard. For bug fix tasks, `prompt-writing-standard` Step 3 ("diagnostics protocol") means executing Phases 1–3 of this skill before writing the fix prompt.
- **`knowledge-structure`** — `decisions.md` is the long-term memory of bug hunts; `rules.md` accumulates rules learned from recurring bugs.
- **`code-markup-standard`** — `RULE:` anchors next to vulnerable code (Section 8 of that skill); rules hierarchy (Section 9) governs where rules live.

---

## 9. Quick Reference — Phase Cheatsheet

| Phase | Goal | Output | Don't do |
|---|---|---|---|
| **Triage (2.5)** | Decide normal vs Emergency Mode | SEV classification | Skip mitigation in SEV-1 |
| **1 — STOP & FRAME** | Understand what you're hunting | Symptom + last working + what changed + similar cases | Touch code, write fix |
| **2 — REPRODUCE** | Reliable way to trigger the bug | Steps / N-run statistic / observability evidence | Skip; fix without reproduction |
| **3 — INVESTIGATE** | Root cause identified and verified | Investigation log with refuted/confirmed hypotheses | Read code before logs; one hypothesis; change two things |
| **4 — CONCLUDE & FIX** | Real fix applied, regression-proofed | Fix prompt + decisions.md + RULE anchor + regression test (when applicable) | Workaround; silent fix; skip neighbor check; close before all 8 closure conditions |
