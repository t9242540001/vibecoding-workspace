# Example Orchard Tools Site Audit Report
<!--
  @file:        examples/site-audit/sanitized-audit-report-example.md
  @description: Synthetic sanitized site-audit report example using fake data only
  @updated:     2026-05-24
  @version:     1.1
-->

## Synthetic Example Notice

This file is synthetic only. Project name, URL, routes, evidence IDs, findings, and prompts are fake. It contains no real client data, credentials, secrets, private URLs, production artifacts, or product-specific content.

# Example Orchard Tools Site Audit Report

## 1. Краткий отчёт для руководителя

- Дата проверки: 2026-05-24
- Аудитор: Code Agent
- Режим проверки: статическая проверка fake fixtures и чтение публичных страниц по готовым очищенным сводкам
- Цель: `https://example.invalid/orchard-tools`
- Итог: найдены замечания по понятности CTA, подписи поля email, согласованности schema-разметки, agentic-readiness и плотности текста на мобильном экране.
- Что проверено: главная, страница цен, страница поддержки, мобильная сводка `mobile_390`, форма подписки без отправки, fake structured-data summary, marketing/AI checklist.
- Что не проверено: отправка форм, личный кабинет, оплата, админка, API/SSE, реальные браузерные действия, скриншоты, сырые HAR/логи, приватные URL.
- Самый высокий риск: High. Пользователь может не понять следующий шаг на главной странице, а поле email может быть неудобным для пользователей вспомогательных технологий.
- Ограничения доказательств: визуальная оценка основана только на очищенных текстовых сводках; DOM, accessibility tree, network, console и screenshots не проверялись.
- Главные следующие действия: добавить понятный CTA; проверить и исправить подпись поля email; согласовать schema-разметку с видимым текстом; добавить стабильную страницу с условиями тарифа.
- Стоп-условия: не возникли.

## 2. Все найденные замечания

| ID | Severity | Коротко | Где найдено | Почему важно | Что делать дальше | Статус |
|---|---|---|---|---|---|---|
| F-001 | High | На главной странице в первом текстовом блоке нет понятного следующего шага. | `example-home`, первый экран по текстовой сводке | Новые посетители могут не понять, как начать оценку продукта. | Добавить понятный основной CTA рядом с начальным описанием и перепроверить approved CTA-profile. | open |
| F-002 | High | У поля email виден placeholder, но не видна постоянная подпись. | `example-support`, форма подписки | Пользователям с ассистивными технологиями может быть сложно понять поле. | Проверить разметку формы и добавить видимую или программную подпись, если её нет. | open |
| F-003 | Medium | Schema-разметка говорит про "free setup", а видимый текст допускает setup fee. | `example-pricing`, structured data signal | Поисковые и AI-сигналы могут стать вводящими в заблуждение. | Согласовать schema-разметку с видимыми условиями цены или удалить неподтверждённое свойство. | open |
| F-004 | Medium | В мобильной текстовой сводке есть длинный непрерывный абзац. | `example-home`, `mobile_390` | Мобильным пользователям может быть сложнее быстро просканировать страницу. | Провести approved mobile visual/browser check; если проблема подтвердится, сократить или разбить текст. | open |
| F-005 | Low | Формулировка "best results guaranteed" не показывает условия гарантии. | `example-pricing` | Без условий обещание может снижать доверие. | Добавить краткие условия рядом с гарантией или смягчить формулировку. | open |
| F-006 | Medium | У тарифа нет стабильной публичной страницы с условиями и ограничениями. | `example-pricing`, pricing summary | Пользователь и AI-ассистент могут неправильно понять цену, ограничения и следующий шаг. | Добавить стабильный раздел или страницу с условиями тарифа, ограничениями, возвратом и поддержкой. | open |
| F-007 | Observation | Публичная аналитика не проверялась. | Все страницы в scope | Дефект не доказан; это возможная отдельная проверка. | Добавить approved static или sanitized browser check, если проверка аналитики станет нужна. | open |

## 3. Метод и ограничения проверки

### Проверенный scope

#### В scope

- Маршруты/страницы:
  - `example-home` -> `https://example.invalid/orchard-tools/`
  - `example-pricing` -> `https://example.invalid/orchard-tools/pricing`
  - `example-support` -> `https://example.invalid/orchard-tools/support`
- Файлы/разделы репозитория:
  - fake metadata fixture
  - fake pricing structured-data fixture
- Устройства/viewport:
  - `desktop_default`
  - `mobile_390`
- Формы/инструменты:
  - newsletter signup form: inspect labels and visible validation hints only; submit not allowed
- Тестовые данные и аккаунты:
  - no test accounts used
  - no form submit data used
- Разрешённые действия:
  - read supplied fake summaries
  - inspect fake public metadata and structured-data summary
  - validate report structure
- Разрешённые артефакты:
  - sanitized summary JSON
  - validation report JSON
  - markdown audit report
  - source line references from fake example fixtures

#### Вне scope

- Маршруты/страницы:
  - account, billing, admin, upload, checkout, private API, and SSE paths
- Файлы/разделы репозитория:
  - real product source files
- Устройства/viewport:
  - screenshots and visual regression captures
- Формы/инструменты:
  - production submit, file upload, payment, login, account creation
- Действия:
  - clicks that send data, auth, payment, admin, destructive actions
- Артефакты:
  - screenshots, videos, traces, raw HAR, cookies, storage, auth headers, raw request bodies, raw response bodies

### Слои проверки

| Слой | Статус | Доказательства или причина недоступности |
|---|---|---|
| Static repository audit | executed | Fake metadata and structured-data fixture summaries reviewed. |
| Live HTTP audit | unavailable | No live HTTP run approved in this synthetic example. |
| Browser visual audit | partially executed | Only sanitized browser summaries were supplied; no screenshot or live browser run. |
| Interactive user-flow audit | unavailable | No submit or reversible interaction was approved. |
| Auth/account audit | unavailable | No test accounts were provided. |
| Payment-path audit | unavailable | No sandbox/test mode or stop-before-charge path was provided. |
| Admin/access-boundary audit | unavailable | No test roles or admin routes were provided. |
| API/server-route/SSE audit | unavailable | No API/SSE endpoints were approved. |
| Marketing/sales/target-audience usefulness audit | executed | `E-001`, `E-002`, and `E-005` reviewed. |
| SEO/AEO/GEO audit | executed | `E-002` and `E-005` reviewed. |
| AI/agentic-commerce readiness audit | executed | `E-002`, `E-005`, and `E-006` reviewed as emerging-practice evidence. |
| Security/privacy/sensitive-data exposure audit | executed | Fake forbidden-pattern scan `E-004` passed; anonymized exposure example `E-007` reviewed. |
| Post-fix regression audit | unavailable | No prior fixes were supplied for retest. |

### Метод и ограничения

- Прочитанный контекст:
  - supplied fake audit scope
  - supplied fake sanitized summaries
  - supplied fake marketing/AI checklist result
  - `templates/site-audit/report-template.md`
  - `templates/site-audit/finding-taxonomy.md`
- Запущенные автоматические проверки:
  - fake summary schema validation: passed
  - fake forbidden-pattern scan: passed
  - fake report-section validation: passed
- Live HTTP evidence:
  - not collected; no live request was approved
- Browser/visual evidence:
  - supplied sanitized summaries only
  - screenshots were not captured or referenced
- Interactive/auth/payment/admin evidence:
  - not collected; layers were unavailable in this public no-auth synthetic scope
- Проверенные очищенные summaries:
  - `E-001`
  - `E-002`
  - `E-003`
  - `E-005`
  - `E-006`
- Тестовые данные/аккаунты использованы:
  - none
- Тестовые данные/аккаунты отсутствовали:
  - auth/account, payment, and admin test accounts were not provided
- Ограничения доказательств:
  - no screenshots or raw browser artifacts were captured
  - mobile layout findings are based on sanitized text and viewport labels only
  - form behavior was not submitted or tested past visible non-submit hints
  - API/SSE behavior was not tested
- Стоп-условия:
  - none encountered

## 4. Marketing, Sales, Target Audience And AI/Agentic Readiness

### Краткая интерпретация

- Польза для целевой аудитории: частично достаточна. Страница объясняет инструмент, но не показывает ясный первый шаг и кому тариф не подходит.
- Эффективность marketing/sales: снижена из-за слабого CTA, неясных условий гарантии и неполной страницы тарифа.
- SEO/AEO/GEO: есть риск из-за противоречия между schema-разметкой и видимым текстом.
- AI-friendliness: AI-ассистент может пересказать основное предложение, но может ошибиться в условиях setup fee.
- Agentic-commerce readiness: частично не готово. Нет стабильной страницы с условиями тарифа, ограничениями, возвратом и следующим действием.
- Что не проверялось и почему: реальные SERP, live crawler, browser DOM, screenshots, checkout and account paths were not approved.

### Coverage Table

| Area | Status | Evidence | Finding IDs / Not-tested reason |
|---|---|---|---|
| Target-audience usefulness | covered | `E-001`, `E-005` | F-001, F-006 |
| Marketing/sales effectiveness | covered | `E-001`, `E-002`, `E-005` | F-001, F-005, F-006 |
| SEO | covered | `E-002`, `E-005` | F-003 |
| AEO/GEO | covered | `E-002`, `E-005` | F-003, F-006 |
| AI-friendliness | covered | `E-005`, `E-006` | F-003, F-006 |
| Agentic-commerce readiness | covered as emerging-practice review | `E-006` | F-006 |

### English Technical Details

- Target audience and decision usefulness: `E-001` explains the product category but does not provide a clear first-step CTA in the first captured segment.
- Offer, pricing, trust, objections, and CTA path: `E-002` contains pricing and guarantee copy, but setup-fee conditions and guarantee limits are not visible in the captured text.
- SEO/AEO/GEO evidence: `E-005` says structured data mentions "free setup" while visible copy allows a setup fee.
- AI assistant readability and recommendation safety: an assistant could summarize the product, but the pricing contradiction creates a risk of wrong recommendation wording.
- Agentic-commerce/service-selection readiness: `E-006` marks missing stable policy and tariff-condition URLs, so service-selection agents would need to infer constraints.
- Emerging-practice caveats: agentic-commerce readiness is treated as emerging practice, not a hard platform requirement.

## 5. English Technical Section

### Evidence Inventory

| Evidence ID | Type | Location | Captured by | Artifact / Reference | Redaction status | Notes |
|---|---|---|---|---|---|---|
| E-001 | sanitized_browser_summary | `example-home`, `mobile_390` | fake browser summary fixture | fake sanitized summary bundle | sanitized | Visible text includes headline, feature snippets, and no clear primary CTA in first text segment. |
| E-002 | sanitized_browser_summary | `example-pricing`, `desktop_default` | fake browser summary fixture | fake sanitized summary bundle | sanitized | Pricing page has table text and guarantee copy. |
| E-003 | sanitized_browser_summary | `example-support`, `desktop_default` | fake browser summary fixture | fake sanitized summary bundle | sanitized | Newsletter field appears as "Email" placeholder only; no visible label in summary. |
| E-004 | validation_report_json | fake summary bundle | fake validator | fake validation report | sanitized | Required fields present and forbidden-pattern scan passed. |
| E-005 | structured_data_summary | `example-pricing` | fake static fixture | fake metadata summary | sanitized | Product schema says "free setup"; visible pricing copy says "setup fee may apply". |
| E-006 | marketing_ai_checklist | `example-pricing` | fake checklist fixture | fake marketing/AI checklist | sanitized | Stable tariff terms and limitations page is not present in supplied evidence. |
| E-007 | anonymized_sensitive_exposure_note | fake browser artifact scan | fake validator | fake stop-safety note | anonymized | A credential-like value was intentionally simulated in a fixture and omitted from this report; no real value exists. |

### Technical Finding Table

| ID | Severity | Category | Location | Observed evidence | Inferred risk | Unknowns | Recommendation | Acceptance criteria | Status |
|---|---|---|---|---|---|---|---|---|---|
| F-001 | High | UX/usability; Marketing/sales effectiveness | `example-home`, first viewport text | Observed: `E-001` includes product explanation but no clear primary next-step text in the first captured segment. | New visitors may not know how to start evaluating the tool, reducing conversion and task clarity. | Actual visual placement was not captured. | Add a clear primary CTA near the opening value statement and verify with an approved CTA-presence profile. | Primary CTA is visible in the first captured home-page segment and approved CTA-presence retest passes. | open |
| F-002 | High | Accessibility; Forms/tools | `example-support`, newsletter form | Observed: `E-003` exposes an email placeholder but no visible label in the sanitized form text. | Users relying on labels or assistive technology may have trouble understanding the field. | Accessible name was not inspected through DOM or accessibility tree. | Inspect the form markup in a scoped follow-up and add a persistent visible or programmatic label if missing. | Newsletter input has a persistent visible or programmatic label and non-submit accessibility check passes. | open |
| F-003 | Medium | SEO; AEO/GEO/AI-friendly content | `example-pricing`, structured data signal | Observed: `E-005` says `Product` schema includes "free setup" while visible pricing copy says "setup fee may apply". | Search and AI answer signals may mislead users about pricing. | Schema validator was not run. | Align structured data with visible pricing terms or remove the unsupported property. | Product schema no longer contradicts visible pricing copy. | open |
| F-004 | Medium | Responsive/mobile | `example-home`, `mobile_390` | Observed: `E-001` contains a long uninterrupted feature paragraph in the mobile text capture. | Mobile readers may face dense scanning friction. | Visual wrapping and actual layout were not captured. | Review mobile layout with an approved visual or browser profile before making a visual claim; consider shorter bullets if confirmed. | Approved mobile visual/browser evidence confirms whether text density remains a defect. | open |
| F-005 | Low | Copy/trust/legal-risk wording | `example-pricing` | Observed: `E-002` includes "best results guaranteed" without visible conditions in the captured text. | The claim may reduce trust if users cannot see limits or conditions. | Legal policy page was not supplied. | Add concise conditions near the guarantee or soften the claim to match actual policy. | Guarantee wording links to or states visible conditions. | open |
| F-006 | Medium | AI/agentic-commerce readiness; Target-audience usefulness | `example-pricing`, tariff terms | Observed: `E-006` reports no stable URL or section for tariff limitations, refund/cancellation, support boundary, or next-step consequence. | Assistants and service-selection agents may recommend the wrong plan or omit constraints. | Checkout, account, and payment path were not approved. | Add a stable pricing terms section or page with limitations, refund/cancellation, support boundaries, and clear next action. | Stable public terms are visible and linked from pricing; assistant summary can state plan limits without inference. | open |
| F-007 | Observation | Analytics/conversion | all in-scope routes | Unknown: public instrumentation was not inspected in the supplied sanitized summaries. | No defect proven; conversion measurement may need separate review. | Analytics source and browser network evidence were not supplied. | Add an approved static or sanitized browser check if instrumentation verification becomes necessary. | Instrumentation check is explicitly completed or remains documented as out of scope. | open |

### Severity Definitions

| Severity | Definition |
|---|---|
| Critical | Blocks a primary user path, exposes secrets/PII, creates auth/payment/admin risk, causes legal/compliance risk, or makes the site unusable. |
| High | Strongly damages task completion, accessibility, trust, SEO discoverability, conversion, or safe decision-making. |
| Medium | Creates meaningful friction, confusion, quality loss, or ranking/measurement weakness without blocking the path. |
| Low | Local polish issue or minor inconsistency with limited user impact. |
| Observation | Useful non-defect signal, opportunity, unknown, or future check that does not currently justify a fix by itself. |

### Recommended Fix Direction

1. F-001 - Add a visible primary CTA and retest with an approved route/profile pair - strongest conversion and user-path risk - fake homepage hero.
2. F-002 - Verify and fix the newsletter field label - likely accessibility and form-completion risk - fake support form.
3. F-003 - Align structured data with visible pricing terms - prevents misleading SEO/AEO/AI signals - fake pricing metadata.
4. F-006 - Add stable pricing terms and limitations - improves target-audience and agentic-readiness clarity - fake pricing route.
5. F-004 - Retest mobile visual layout with approved evidence before making design changes - current evidence is text-only - fake homepage mobile route.

### Acceptance Criteria And Follow-Up Prompts

| Finding ID | Acceptance criteria | Suggested next batch or prompt |
|---|---|---|
| F-001 | Primary CTA is visible in the first captured home-page segment and approved CTA-presence retest passes. | Create a scoped copy/UI prompt for the fake homepage hero CTA. |
| F-002 | Newsletter input has a persistent visible or programmatic label and non-submit accessibility check passes. | Create a scoped form-markup prompt for the fake support newsletter field. |
| F-003 | Product schema no longer contradicts visible pricing copy. | Create a scoped metadata/schema prompt for fake pricing terms. |
| F-004 | Approved mobile visual/browser evidence confirms whether text density remains a defect. | Create a mobile evidence collection prompt before layout changes. |
| F-006 | Stable pricing terms, limitations, refund/cancellation, support boundaries, and next action are visible and linked. | Create a scoped pricing-content prompt for fake tariff terms. |

## 6. Safety / Boundary Notes

- Product code changed during audit: No.
- Product content/config/infrastructure changed during audit: No.
- Production form submit: not performed.
- Auth/admin/payment/account flows: not accessed.
- Real personal/client/payment data: not used.
- Secrets/deploy/server/database actions: not used.
- Screenshots/videos/traces/raw HAR/cookies/storage/auth headers: not collected.
- Sensitive data disclosure: no sensitive data was disclosed.
- Sensitive data anonymization: `E-007` demonstrates an anonymized synthetic exposure note. The fake credential-like value is omitted and no real value exists.

### Stop Conditions

| Condition | Encountered? | Evidence / Decision |
|---|---:|---|
| Scope drift | No | Routes stayed within fake approved route labels. |
| Secret/credential exposure | No | Fake forbidden-pattern scan in `E-004` passed; synthetic exposure example `E-007` contains no value. |
| Real personal/client/payment data | No | Synthetic example data only. |
| Unapproved submit/auth/payment/admin action needed | No | Newsletter form was not submitted; unavailable layers were reported. |
| Deploy/server/database/secrets action needed | No | Audit report only. |
| Required evidence outside artifact policy | No | Browser-only visual questions were marked unknown. |
| Product modification needed during audit | No | No product source was edited. |
| Ambiguous scope or unsafe prerequisite | No | Missing auth/payment/admin prerequisites were listed as unavailable layers. |

## 7. Next Fix Batches

| Priority | Batch | Findings addressed | Scope | Checks | Approval needed? |
|---|---|---|---|---|---|
| 1 | Add homepage CTA clarity | F-001 | Edit fake homepage hero copy and CTA component; run static checks and approved CTA-presence retest. | Static copy check; approved CTA-presence retest. | Browser retest requires approved route/profile. |
| 2 | Verify and fix newsletter label | F-002 | Inspect fake form markup; add visible or programmatic label if missing; run accessibility checks. | Non-submit accessibility check. | No submit approval needed if non-submit only. |
| 3 | Align pricing structured data | F-003 | Compare fake pricing copy and schema; update schema to match visible content. | Schema validation; visible-content alignment check. | No browser approval needed for static source audit. |
| 4 | Add stable pricing terms for AI/agentic readiness | F-006 | Add linked fake tariff terms, limitations, refund/cancellation, support boundaries, and next-step consequence. | Content checklist; marketing/AI checklist. | Product-content edit approval in real repositories. |
| 5 | Mobile text-density follow-up | F-004 | Run approved mobile visual/browser inspection before changing layout. | Approved mobile visual/browser check. | Visual evidence approval required if screenshots are needed. |
