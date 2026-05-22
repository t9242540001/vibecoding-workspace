# Site Audit Report Template
<!--
  @file:        templates/site-audit/report-template.md
  @description: Reusable structured report format for website audits
  @updated:     2026-05-22
  @version:     1.0
-->

# [Project] Site Audit Report

## 1. Краткий отчёт для руководителя

Use Russian. Keep wording short and simple for a non-developer decision-maker.

- Дата проверки:
- Аудитор:
- Режим проверки:
- Целевой URL/репозиторий:
- Общий результат:
- Самый высокий риск:
- Что проверено:
- Что не проверено:
- Главные приоритеты:
- Стоп-условия:

## 2. Все найденные замечания

Use Russian. Include every finding, not only the highest-priority items.

Each item must include:

- ID:
- Severity: `Critical`, `High`, `Medium`, `Low`, or `Observation` with a Russian explanation where helpful.
- Short problem:
- Where found:
- Why it matters:
- What to do next:

## 3. Метод и ограничения проверки

Use Russian. State the audit mode, checked pages/files, skipped scope, unavailable evidence, and stop conditions.

### Проверенный scope

#### В scope

- Маршруты/страницы:
- Устройства/viewport:
- Формы/инструменты:
- Измерения проверки:
- Разрешённые артефакты:

#### Вне scope

- Маршруты/страницы:
- Устройства/viewport:
- Формы/инструменты:
- Действия:
- Артефакты:

### Метод и ограничения

- Прочитанный контекст:
- Запущенные автоматические проверки:
- Ручные/browser observations:
- Проверенные очищенные summaries:
- Ограничения доказательств:

## 4. English Technical Section

Use English. This section is for Code Agent and developer execution. Keep precise technical details, file paths, routes, evidence, inferred risks, recommended fix direction, acceptance criteria, and follow-up prompt suggestions.

### Evidence Inventory

| Evidence ID | Type | Location | Captured by | Notes |
|---|---|---|---|---|
| E-001 |  |  |  |  |

### Technical Finding Table

| ID | Severity | Category | Location | Evidence | Impact | Recommendation | Status |
|---|---|---|---|---|---|---|---|
| F-001 |  |  |  |  |  |  | open |

### Severity Definitions

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

### Prioritized Recommendations

1. [Finding ID] - [Action] - [Reason]
2. [Finding ID] - [Action] - [Reason]
3. [Finding ID] - [Action] - [Reason]

### Acceptance Criteria And Follow-Up Prompts

| Finding ID | Acceptance criteria | Follow-up prompt suggestion |
|---|---|---|
| F-001 |  |  |

## 5. Safety / Boundary Notes

- Production form submit:
- Auth/admin/payment/account flows:
- Real personal data:
- Secrets/deploy/server/database actions:
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers:
- Code changes during audit:

### Stop Conditions

| Condition | Encountered? | Evidence / Decision |
|---|---:|---|
| Scope drift |  |  |
| Secret/credential exposure |  |  |
| Real personal/client/payment data |  |  |
| Unapproved submit/auth/payment/admin action needed |  |  |
| Deploy/server/database/secrets action needed |  |  |
| Required evidence outside artifact policy |  |  |

## 6. Next Fix Batches

List recommended next fix batches in priority order.

| Batch | Findings addressed | Scope | Approval needed? |
|---|---|---|---|
|  |  |  |  |
