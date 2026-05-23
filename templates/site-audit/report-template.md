# Site Audit Report Template
<!--
  @file:        templates/site-audit/report-template.md
  @description: Reusable structured report format for full website audits
  @updated:     2026-05-24
  @version:     1.1
-->

# [Project] Site Audit Report

## 1. Краткий отчёт для руководителя

Use Russian. Keep wording short and simple for a non-developer decision-maker.

- Дата проверки:
- Аудитор:
- Режим проверки:
- Целевой URL/репозиторий:
- Общий результат:
- Что проверено:
- Что не проверено:
- Самый высокий риск:
- Ограничения доказательств:
- Главные следующие действия:
- Стоп-условия:

## 2. Все найденные замечания

Use Russian. Include every finding, not only the highest-priority items. If there are no findings, state that directly and keep the table with `none`.

Each item must include:

- ID:
- Severity: `Critical`, `High`, `Medium`, `Low`, or `Observation` with a Russian explanation where helpful.
- Short problem:
- Where found:
- Why it matters:
- What to do next:
- Status: `open`, `fixed`, `partially fixed`, `not fixed`, `new regression`, or `not retested`.

| ID | Severity | Коротко | Где найдено | Почему важно | Что делать дальше | Статус |
|---|---|---|---|---|---|---|
| F-001 |  |  |  |  |  | open |

## 3. Метод и ограничения проверки

Use Russian. State the enabled audit layers, unavailable audit layers with reasons, checked pages/files, skipped scope, test data/accounts used or missing, live/browser/interactive evidence limitations, and stop conditions.

### Проверенный scope

#### В scope

- Маршруты/страницы:
- Файлы/разделы репозитория:
- Устройства/viewport:
- Формы/инструменты:
- Тестовые данные и аккаунты:
- Разрешённые действия:
- Разрешённые артефакты:

#### Вне scope

- Маршруты/страницы:
- Файлы/разделы репозитория:
- Устройства/viewport:
- Формы/инструменты:
- Действия:
- Артефакты:

### Слои проверки

| Слой | Статус | Доказательства или причина недоступности |
|---|---|---|
| Static repository audit |  |  |
| Live HTTP audit |  |  |
| Browser visual audit |  |  |
| Interactive user-flow audit |  |  |
| Auth/account audit |  |  |
| Payment-path audit |  |  |
| Admin/access-boundary audit |  |  |
| API/server-route/SSE audit |  |  |
| Marketing/sales/target-audience usefulness audit |  |  |
| SEO/AEO/GEO audit |  |  |
| AI/agentic-commerce readiness audit |  |  |
| Security/privacy/sensitive-data exposure audit |  |  |
| Post-fix regression audit |  |  |

### Метод и ограничения

- Прочитанный контекст:
- Запущенные автоматические проверки:
- Live HTTP evidence:
- Browser/visual evidence:
- Interactive/auth/payment/admin evidence:
- Проверенные очищенные summaries:
- Тестовые данные/аккаунты использованы:
- Тестовые данные/аккаунты отсутствовали:
- Ограничения доказательств:
- Стоп-условия:

## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness

Use short Russian interpretation first. Add English technical details where useful. Cover every listed area, or mark it `not tested` with a reason.

### Краткая интерпретация

- Польза для целевой аудитории:
- Эффективность marketing/sales:
- SEO/AEO/GEO:
- AI-friendliness:
- Agentic-commerce readiness:
- Что не проверялось и почему:

### Coverage Table

| Area | Status | Evidence | Finding IDs / Not-tested reason |
|---|---|---|---|
| Target-audience usefulness |  |  |  |
| Marketing/sales effectiveness |  |  |  |
| SEO |  |  |  |
| AEO/GEO |  |  |  |
| AI-friendliness |  |  |  |
| Agentic-commerce readiness |  |  |  |

### English Technical Details

- Target audience and decision usefulness:
- Offer, pricing, trust, objections, and CTA path:
- SEO/AEO/GEO evidence:
- AI assistant readability and recommendation safety:
- Agentic-commerce/service-selection readiness:
- Emerging-practice caveats:

## 5. English Technical Section

Use English. This section is for Code Agent and developer execution. Include precise technical details, file paths, routes, selectors, artifacts, observed evidence, inferred risks, unknowns, recommended fix direction, acceptance criteria, and suggested next batches.

### Evidence Inventory

| Evidence ID | Type | Location | Captured by | Artifact / Reference | Redaction status | Notes |
|---|---|---|---|---|---|---|
| E-001 |  |  |  |  |  |  |

### Technical Finding Table

| ID | Severity | Category | Location | Observed evidence | Inferred risk | Unknowns | Recommendation | Acceptance criteria | Status |
|---|---|---|---|---|---|---|---|---|---|
| F-001 |  |  |  |  |  |  |  |  | open |

### Severity Definitions

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

### Recommended Fix Direction

1. [Finding ID] - [Action] - [Reason] - [Affected files/routes/selectors]
2. [Finding ID] - [Action] - [Reason] - [Affected files/routes/selectors]
3. [Finding ID] - [Action] - [Reason] - [Affected files/routes/selectors]

### Acceptance Criteria And Follow-Up Prompts

| Finding ID | Acceptance criteria | Suggested next batch or prompt |
|---|---|---|
| F-001 |  |  |

## 6. Safety / Boundary Notes

This section must explicitly state that product code was not changed, sensitive data was not disclosed, and any sensitive material encountered was anonymized.

- Product code changed during audit: No.
- Product content/config/infrastructure changed during audit:
- Production form submit:
- Auth/admin/payment/account flows:
- Real personal/client/payment data:
- Secrets/deploy/server/database actions:
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers:
- Sensitive data disclosure:
- Sensitive data anonymization:

### Stop Conditions

| Condition | Encountered? | Evidence / Decision |
|---|---:|---|
| Scope drift |  |  |
| Secret/credential exposure |  |  |
| Real personal/client/payment data |  |  |
| Unapproved submit/auth/payment/admin action needed |  |  |
| Deploy/server/database/secrets action needed |  |  |
| Required evidence outside artifact policy |  |  |
| Product modification needed during audit |  |  |
| Ambiguous scope or unsafe prerequisite |  |  |

## 7. Next Fix Batches

List recommended next fix batches in priority order. Fix batches must cite finding IDs, affected files/routes, regression shield, checks, and approval needs.

| Priority | Batch | Findings addressed | Scope | Checks | Approval needed? |
|---|---|---|---|---|---|
| 1 |  |  |  |  |  |
