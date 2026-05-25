# Site Audit V3 Architecture Contract
<!--
  @file:        docs/site-audit/v3-architecture-contract.md
  @description: Architecture contract for the Site Audit V3 multi-agent audit pipeline
  @updated:     2026-05-25
  @version:     1.0
-->

## Purpose

Site Audit V3 wraps and upgrades the existing V2 audit assets through a stricter, multi-agent, evidence-based pipeline. V3 does not replace, rename, or delete V2 files immediately. Existing V2 skills, documents, templates, and configs remain usable while V3 adds outcome statuses, evidence classes, agent roles, aggregation, validation, and Obsidian output rules.

Static fallback is allowed only as a downgraded audit outcome. A static-only run can produce useful findings, but it cannot be labelled `full_live_browser_audit_completed` because that status requires successful preflight plus live/browser/flow evidence for the declared full scope.

## Pipeline Stages

### 1. Scope & Orchestration

Purpose: convert the audit request into an approved scope and route work to V3 agents.

Inputs: product repository, site URL, approved routes, enabled layers, viewports, test-account/payment/admin boundaries, artifact policy, report path, Obsidian handoff path, stop conditions.

Outputs: audit scope contract, agent execution plan, required evidence list, initial unavailable layers.

Allowed decisions: narrow scope, sequence agents, disable unavailable layers, require preflight before evidence collection.

Forbidden decisions: broaden routes or artifacts, authorize product changes, assume test accounts or sandbox payments exist, claim full audit before evidence exists.

Handoff: send the scope contract to the Preflight Gate.

### 2. Preflight Gate

Purpose: decide whether the requested audit can run as full live/browser, partial, or blocked.

Inputs: scope contract, tool availability, URL/DNS reachability, browser capability, approved routes, credentials availability by class only, sandbox or stop-before-charge boundary, artifact policy.

Outputs: one of `go_full_live_browser_audit`, `go_partial_audit_with_unavailable_layers`, or `blocked_at_preflight`; unavailable-layer register; evidence prerequisites.

Allowed decisions: downgrade outcome, block unsafe execution, require missing approvals, proceed with supported layers.

Forbidden decisions: proceed through missing safety prerequisites, expose credentials, run real payments, perform destructive admin actions, mark full audit without required live/browser/flow prerequisites.

Handoff: send gate result and unavailable layers to Discovery.

### 3. Discovery

Purpose: map the site, repository, routes, flows, and evidence sources available under the gate result.

Inputs: scope contract, preflight result, repository context, approved live routes, supplied summaries, previous reports.

Outputs: route map, content/component inventory, primary flows, evidence plan, agent assignment map.

Allowed decisions: identify route priority, mark unknowns, define evidence IDs, route findings to specialist agents.

Forbidden decisions: crawl broadly, infer private routes, execute unapproved interactions, decide final risk priority.

Handoff: send the discovery package to Independent Expert Passes.

### 4. Independent Expert Passes

Purpose: let specialized agents inspect their own dimension without hiding conflicts or overstepping role boundaries.

Inputs: scope, gate result, discovery package, evidence registry, relevant source/live/browser summaries.

Outputs: agent handoffs with findings, evidence IDs, assumptions, limitations, self-checks, and unresolved questions.

Allowed decisions: create role-scoped findings, request more evidence, mark unsupported items as hypotheses, report unavailable layers.

Forbidden decisions: change product files, give legal opinions, run destructive security tests, promise SEO rankings, claim browser evidence without browser evidence classes.

Handoff: send all handoffs to the Risk Board.

### 5. Risk Board

Purpose: review all findings for severity, sensitive-data safety, conflict, duplication, and decision impact.

Inputs: all agent handoffs, evidence registry, outcome status registry, severity taxonomy, scope and limitations.

Outputs: accepted findings, rejected/downgraded findings, conflict decisions, priority model, risk register.

Allowed decisions: accept, downgrade, merge, split, or reject findings with reasons; preserve minority findings.

Forbidden decisions: silently drop findings, quote sensitive values, convert unsupported recommendations into facts, override evidence rules for convenience.

Handoff: send accepted findings and risk decisions to the Report Aggregator.

### 6. Report Aggregator

Purpose: turn specialist handoffs into a single decision-maker report and technical appendix.

Inputs: risk-board output, accepted findings, evidence table, outcome status, unavailable layers, fix-batch candidates.

Outputs: final V3 report, audit completeness statement, evidence summary, conflict decisions, prioritized fix-batch queue.

Allowed decisions: choose final wording, group findings, assign fix-batch priority, state limitations.

Forbidden decisions: overstate completeness, remove limitations, hide unsupported evidence, mix fact and opinion.

Handoff: send report and fix-batch queue to Obsidian Project Output and future fix planning.

### 7. Fix-Batch Queue

Purpose: translate findings into scoped implementation prompts without executing fixes during the audit.

Inputs: accepted findings, impacts, recommendations, affected files if known, approval gates, safety boundaries.

Outputs: prioritized fix-batch candidates with finding IDs, evidence, affected surfaces, checks, and stop conditions.

Allowed decisions: group related findings, mark approval-required fixes, defer unsafe or unclear work.

Forbidden decisions: deploy, push code changes, modify product repositories, approve secrets/server/payment/admin actions.

Handoff: send candidates to the human/operator or a separate product batch.

### 8. Obsidian Project Output

Purpose: preserve audit knowledge in project-specific notes without making Obsidian the source of reusable infrastructure.

Inputs: final report, outcome status, evidence summary, finding register, fix-batch queue, decisions/questions.

Outputs: additive project audit note, status history entry, finding register link, fix-batch queue note, decision handoff.

Allowed decisions: prepare a handoff path and additive note template.

Forbidden decisions: reorganize the local vault, write secrets, duplicate product repository source of truth, write raw browser/session artifacts.

Handoff: send the output map to human review or an approved Obsidian sync step.

### 9. Post-fix Regression Audit

Purpose: retest prior finding IDs after separately approved fixes.

Inputs: final report, fix commits or changed files, original findings, approved retest scope, evidence policy.

Outputs: `post_fix_regression_completed` or `post_fix_regression_partial`, retest evidence, finding status updates.

Allowed decisions: mark fixed, partially fixed, not fixed, new regression, or not retested.

Forbidden decisions: broaden scope without approval, retest with missing evidence as full, mutate production state.

Handoff: send regression report to product repository report path and Obsidian handoff.

## Core Contracts

Audit outcome status contract: final reports must use a status from `configs/site-audit-v3-outcome-statuses.json`. Status must derive from preflight and actual evidence, not intended scope.

Evidence registry contract: all findings cite evidence classes from `configs/site-audit-v3-evidence-registry.json`. Sensitive exposures are reported by class and safe location only.

Agent registry contract: all role passes use IDs, missions, dependencies, and tunable parameters from `configs/site-audit-v3-agent-registry.json`.

Agent output/handoff contract: every agent emits the V3 handoff template with scope slice, unavailable layers, findings, evidence, assumptions, self-check, and aggregator summary.

Aggregator/risk-board contract: unsupported findings are rejected or downgraded, duplicates are merged without hiding separate impacts, conflicts are recorded, and minority findings are preserved with decisions.

Obsidian output contract: reusable methodology remains in GitHub; project-specific audit output is additive, sanitized, and safe for the local vault handoff.

Validation-gate contract: readiness, evidence, status, report, fix-batch, and Obsidian safety checks must pass before a V3 audit report is marked ready.

