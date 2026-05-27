# AI Discovery Disciplines Standard

<!--
  @file:        standards/ai-discovery-disciplines-standard.md
  @description: Reference standard для трёх дисциплин обнаружения брендов в AI-поиске:
                SEO (retrieval), AEO (extraction), GEO (trust + repeated reuse).
                Содержит глоссарий, метрики, эмпирические правила, platform-specifics,
                authoritative sources. Используется skill geo-content-discipline и
                ai-visibility-measurement-ritual как fact-base.
  @owner:       Vibe Coding
  @updated:     2026-05-24
  @version:     1.0
-->

Этот стандарт фиксирует **что такое** SEO/AEO/GEO как три отдельные, но связанные дисциплины обнаружения брендов в поисковых системах и AI-ассистентах в 2026 году. Он не содержит **процедур** (триггеры, шаги при ревью статьи, ритуалы измерения) — это материал skill-файлов `skills/geo-content-discipline/` и `skills/ai-visibility-measurement-ritual/`, которые ссылаются сюда за фактурой.

Стандарт описывает универсальные механизмы, применимые к любому продукту/бренду. Конкретный статус JCK AUTO (что уже сделано, что нет) — отдельная секция §7 как живой snapshot, обновляется по мере работ.

---

## 1. Глоссарий и архитектура: три последовательных слоя

Brandi AI framework 2026 формализует три дисциплины как **прогрессию**, а не три параллельные стратегии. Без нижнего слоя верхний не работает.

```
┌─────────────────────────────────────────────────────────────┐
│  GEO  — Trust + repeated reuse                              │
│  Цель: AI повторно цитирует бренд в синтезированных ответах │
│  Метрика: Citation Frequency, Share of Voice, Mention Rate  │
├─────────────────────────────────────────────────────────────┤
│  AEO  — Extraction                                          │
│  Цель: AI вытаскивает нужный кусок контента как ответ       │
│  Метрика: featured snippet appearance, direct-answer rate   │
├─────────────────────────────────────────────────────────────┤
│  SEO  — Retrieval                                           │
│  Цель: страница попадает в индекс и в топ органической      │
│  Метрика: позиция в SERP, organic traffic                   │
└─────────────────────────────────────────────────────────────┘
```

### 1.1 SEO (Search Engine Optimization)

Классическая дисциплина оптимизации страниц под алгоритмы ранжирования Google / Yandex / Bing для появления в списке результатов. Базируется на: crawlability, backlinks, on-page signals, technical foundation (HTTPS, mobile-friendly, Core Web Vitals), keyword targeting.

**Цель:** позиция в SERP. **Конверсия:** клик пользователя по ссылке.

В 2026 SEO **не мёртв** — он остаётся фундаментом, на котором стоят AEO и GEO. AI-системы вытаскивают источники через web search (live retrieval), и сайт без работающего SEO не попадёт даже в pool кандидатов. Google всё ещё отправляет в 345 раз больше трафика, чем ChatGPT + Gemini + Perplexity вместе взятые (Ahrefs 2025).

### 1.2 AEO (Answer Engine Optimization)

Оптимизация контента **под прямой ответ** — featured snippet, Position 0, Google AI Overview, голосовой ассистент. Узкая, ответ-специфичная задача. Существовала до LLM-эпохи (для голосовых помощников), но в 2026 расширилась под AI Overviews и AI Mode.

**Цель:** быть выбранным как источник прямого ответа. **Конверсия:** упоминание в одном-двух блоках при синтезе.

Ключевые тактики AEO: Answer-first структура (главный ответ в первых 30–60 словах H2-секции), FAQPage schema, конкретные краткие формулировки (50–60 слов на блок), таблицы и нумерованные списки вместо «простыни» текста.

### 1.3 GEO (Generative Engine Optimization)

Оптимизация всей **digital presence** бренда (контент + структурированные данные + off-site сигналы + entity authority) для **повторного цитирования** AI-системами при синтезе ответов на разнообразные запросы.

**Цель:** попадать в синтезированный ответ LLM как **mention** или **citation** регулярно, по множеству промптов, на разных платформах. **Конверсия:** brand awareness в pre-purchase decision, прямые заходы по упомянутому URL, последующие conversational запросы.

GEO — самая широкая дисциплина: она поглощает AEO как частный случай (AEO — это GEO для запросов с ожиданием прямого ответа) и опирается на SEO снизу.

### 1.4 Связанные термины (синонимы и подмножества)

Терминология **ещё не устоялась** (eMarketer FAQ, апрель 2026). 59% SEO-инфлюенсеров признают пересечение между:

- **LLMO** (Large Language Model Optimization) — иногда используется как синоним GEO, иногда узко — про влияние на параметрическое знание модели (через её training data), а не через retrieval.
- **AIO** (AI Optimization) — широкий зонтик, обычно равен GEO или GEO + agentic commerce-готовность.
- **GSO** (Generative Search Optimization) — синоним GEO, реже встречается.
- **AI SEO** — практический ярлык, обычно означает SEO + AEO + GEO суммарно.

В этом стандарте используем триаду **SEO / AEO / GEO** как точную и достаточную.

---

## 2. Эмпирические правила (что подтверждено исследованиями)

### 2.1 Princeton + 5 follow-up academic papers

**Princeton, Georgia Tech, Allen AI, IIT Delhi, KDD 2024** (arxiv 2311.09735, Aggarwal et al.). Бенчмарк GEO-bench на 10 000 запросов и 25 доменов. Ключевой результат:

| Контент-модификация | Lift visibility в AI-ответах |
|---|---|
| Добавление quotations (цитат авторитетов) | **+41%** |
| Добавление statistics (конкретных чисел) | **+30 до +32%** |
| Citations of low-ranked but authoritative sources | **+115%** (для изначально низко-ранжированных) |
| Improved fluency | **+28%** |
| Простое увеличение word count | 0% (не помогает) |

**Follow-up работы 2025–2026** (см. §8 для полного списка):

- Chen et al. 2025 (arxiv 2509.08919) — «How to Dominate AI Search». Расширение GEO за пределы content-level в brand entity-level.
- Tian et al. 2026 (arxiv 2603.09296) — **diagnostic framework для разбора citation failures**. Если бренд не цитируется, можно классифицировать причину (retrieval miss / extraction failure / trust deficit).
- Liu & Xu 2026 (arxiv 2604.19113) — feature-level multi-objective optimization. Контент рассматривается как вектор features, GEO как Pareto-optimization.
- Yuan et al. 2026 (arxiv 2603.20213) — **AgenticGEO**: self-evolving система оптимизации. Агент сам прогоняет промпты, измеряет citation, итерирует контент.
- Yu et al. 2026 (arxiv 2603.29979) — structural feature engineering. Как разметка (headings, lists, schema) влияет на extraction.

### 2.2 Citation Economy и earned media

**Profound research 2026** (цитируется в большинстве GEO-гайдов): **97.4% AI-citations приходят из non-Tier-1 earned media** — Reddit threads, niche YouTube videos, LinkedIn posts, long-tail vertical sites. **НЕ** Forbes, Bloomberg, Associated Press.

Lorenz Wacker (digitalagenten GmbH Berlin) ввёл термин **Citation Economy**: «быть процитированным» становится условием существования бренда для AI-пользователя. Бренд, существующий **только на собственном сайте**, для AI-системы — unverified entity.

### 2.3 Источники цитирований по платформам

По данным Semrush (январь 2026) для англоязычного сегмента:

- **Reddit** — самый цитируемый домен у ChatGPT, Perplexity, Google AI Mode.
- **LinkedIn** — на 2-м месте (особенно для B2B).
- **YouTube** — растущий источник, цитируется в Gemini и Perplexity.
- **Wikipedia** — 47.9% всех AI-цитирований в общем срезе (digital-агенты Германия).

Для Рунета:
- **Карты, Кью, Дзен** — приоритетные источники Яндекс Нейро (ODAA Studio, 2026).
- **Pikabu, DTF, vc.ru, Drive2, Drom.ru** — эквиваленты Reddit для русскоязычной аудитории, пока недо-исследованы в публичных бенчмарках, но цитируются Яндекс Нейро при матче по теме.

### 2.4 Свежесть контента критична

- 85% AI Overview citations — из контента не старше 2 лет (Seer Interactive 2025).
- 44% — из контента, опубликованного в 2025 году.
- Свежий контент цитируется в **4.3 раза чаще**, чем устаревший (тот же отчёт).

### 2.5 LLM-ответы не детерминированы

**SparkToro + Gumshoe.ai, 27 января 2026.** Прогон одних и тех же промптов даёт разные ответы. Метрика «есть/нет в ответе» бессмысленна без ensemble testing. Используется **frequency** (mention rate across N runs), не **position**.

---

## 3. Метрики GEO/AEO

### 3.1 Основные KPI

| Метрика | Что измеряет | Как считать |
|---|---|---|
| **Citation Frequency** | Сколько раз бренд процитирован по N промптам | (число ответов с citation) / N |
| **Mention Rate** | Сколько раз имя бренда упомянуто (с/без ссылки) | (число ответов с mention) / N |
| **Share of Voice (SoV)** | Доля бренда среди всех упомянутых конкурентов | (mentions бренда) / (mentions всех в категории) |
| **Sentiment** | Окраска упоминаний — позитив / нейтрал / негатив | manual или классификатор по N runs |
| **Citation Position** | Где в ответе появляется citation (топ / середина / низ) | average position по N runs |
| **Source Diversity** | На скольких платформах бренд цитируется | unique platforms / total tested |
| **Prompt Win Rate** | Доля промптов, где бренд хоть раз процитирован | (промптов с ≥1 mention) / (всех промптов в наборе) |

### 3.2 Что не работает как метрика

- **Position #1** не существует в LLM-ответах. Ответы синтезируются, не ранжируются как список.
- **Один прогон промпта** не репрезентативен. Минимум 5–10 прогонов одного промпта для ensemble.
- **Только Yandex Metrika UA-сегменты** (GPTBot, ClaudeBot и т.д.) — это метрика **визита краулера**, не **цитирования в ответе**. Они независимы: краулер может прийти и не процитировать, или процитировать без явного визита (если контент в его training data).

### 3.3 Инструменты измерения

| Инструмент | Что делает | Применимость для JCK |
|---|---|---|
| **Profound** | Enterprise-уровень, log-level AI crawler data, GA4 attribution, multilingual | Дорого, для крупных брендов |
| **Semrush AI Visibility Toolkit** | Share of Voice across ChatGPT/Claude/Gemini, sentiment, competitor compare | Платный, доступен |
| **Bing Webmaster Tools AI Performance** | Первый «GSC для AI» от Microsoft (фев 2026) — присутствие в Bing/Copilot AI | Бесплатный, частично применим |
| **Ziptie.dev** | Unlinked mentions across AI outputs | Раннее состояние, мониторить |
| **Manual prompt testing** | Ручной прогон промптов на 5 платформах + таблица | Бесплатно, базовый baseline |

Для JCK AUTO в краткосрочной перспективе — **manual prompt testing** как baseline; платные инструменты при росте бюджета и расширении на 2–3 рынка.

---

## 4. Platform-specific механика

### 4.1 ChatGPT (OpenAI)

- 900+ млн еженедельных пользователей на февраль 2026 (Reuters).
- В browsing-режиме использует live web search (через Bing/собственный crawler).
- В non-browsing — отвечает из training data (стрижка декабрь 2024 / июнь 2025 / октябрь 2025 в зависимости от модели).
- Crawler: **GPTBot** (training), **ChatGPT-User** (live browsing), **OAI-SearchBot** (search index).
- ChatGPT e-commerce трафик конвертирует на **31% выше**, чем traditional organic (по данным Yotpo).
- Любит структурированные ответы, quotations, statistics. Princeton-факторы работают.

### 4.2 Claude (Anthropic)

- Crawler: **ClaudeBot** (training), **Claude-Web**, **claude-user**.
- В режиме с web search использует live retrieval.
- Citation behavior строже — Claude чаще ссылается на конкретные источники, чем синтезирует от своего имени.
- Хорошо понимает Schema.org разметку.

### 4.3 Perplexity

- Гибрид: всегда live search + LLM-синтез поверх результатов.
- Crawler: **PerplexityBot**.
- Очень показывает источники в UI, что делает Perplexity главным «инструментом измерения» вручную: видно, кто процитирован.
- Reddit и LinkedIn особенно активно цитируются.

### 4.4 Google AI Overviews + AI Mode

- Появляется на ~16% всех запросов Google (Semrush 2025), 13.1% (март 2026, для франкоязычного сегмента).
- Использует Gemini поверх Google Search Index.
- В Германии: 27.86% всех запросов триггерят AI Overview (SE Ranking 2025).
- **Paid CTR падает на 68%** на запросах с AI Overviews — органическая AI-видимость становится критичной.
- Любит entity authority через Knowledge Graph (Wikidata sameAs links).

### 4.5 Yandex Neuro / Алиса AI (Россия)

**Критично для JCK AUTO** — основной канал в РФ.

- Базовая модель: **YandexGPT 5.1 Pro** (с конца 2025 переименовано в Алиса AI на пользовательском уровне).
- **Берёт ровно 5 источников из топ-30 органической выдачи**. Условие №1 — попадание в топ-30 классическим SEO.
- 5 требований для цитирования (Александр Тригуб, 2026):
  1. E-E-A-T сигналы (экспертный автор, идентифицируемая организация).
  2. Техническая структура (Schema.org, semantic HTML).
  3. AEO-формат ответа (Answer-first, первый абзац — суть).
  4. Актуальность (свежий `dateModified`, обновление контента).
  5. Уникальные данные (свои числа, кейсы, расчёты — не пересказ).
- Ценит свежий контент из **Яндекс Карт, Кью, Дзена** + поведенческие сигналы (время на сайте, отказы, отзывы).
- Crawler: **YandexBot** (общий), плюс отдельный для Нейро (на 2026 публично не выделен в отдельный UA).
- **Органический трафик инфо-ресурсов упал на ~30% в 2025** из-за нейроответов (исследование Kokoc Performance).

### 4.6 DeepSeek (Китай)

- Архитектура «意图识别 — 内容匹配 — 来源溯源» (intent recognition → content matching → source attribution).
- Click-through из DeepSeek citation = **2–3× традиционного search** (Chuanshenggang 2026).
- **Фильтрует**: keyword stuffing, шаблонные ranking-list статьи, фейк-геосигналы (IP-маскировка). Попадание в blacklist при обнаружении.
- Переход к семантическому пониманию + **multi-source verification**: информация из одного источника = «сомнительно», из нескольких авторитетных = «достоверно».
- Релевантно для JCK как канал в Китае (поставщики, китайские покупатели в РФ).

### 4.7 豆包 Doubao (ByteDance)

- Высокая мобильная пенетрация, основной C2C-канал в КНР.
- Локализация и immediate-information bias.
- Релевантно для JCK при работе с китайскими клиентами или партнёрами.

### 4.8 Qwen (Alibaba) / Tencent Yuanbao / Baidu Wenxin

- Qwen — сильна в long-text reasoning, B2B-сценарии, у Alibaba собственная экосистема Taobao/Tmall.
- Tencent Yuanbao — интеграция с WeChat-экосистемой.
- Baidu Wenxin — встроена в Baidu Search.
- Все три для JCK — вторичные каналы (через китайских поставщиков), мониторим, не оптимизируем точечно в 2026.

### 4.9 Региональные доли (грубая карта 2026)

| Регион | Доминирующие AI-каналы |
|---|---|
| Россия | Yandex Neuro (Алиса AI), ChatGPT, GigaChat, YaGPT, Claude |
| EU / global EN | ChatGPT, Google AI Overviews, Perplexity, Claude, Gemini |
| Germany | ChatGPT + Google AI Overviews (27.86% запросов), Perplexity |
| France | ChatGPT (rollout AI Overviews FR ожидается H1 2026), Perplexity |
| China | DeepSeek, Doubao, Qwen, Tencent Yuanbao, Baidu Wenxin |
| LATAM | ChatGPT, Perplexity, Google AI Overviews |

---

## 5. Agentic Commerce stack (май 2026 snapshot)

Контекст для JCK AUTO Wave B/C planning. Это smapshot, **обновляется быстро** — перепроверять при следующей ревизии стандарта.

### 5.1 Шесть протоколов работающего стека

| Протокол | Владелец | Назначение |
|---|---|---|
| **MCP** (Model Context Protocol) | Anthropic | Tool / data access для агентов. De facto стандарт. Shopify ставит `/api/mcp` на каждом магазине по умолчанию. |
| **ACP** (Agentic Commerce Protocol) | OpenAI + Stripe | Product feed format + checkout session. Apache 2.0. |
| **UCP** (Universal Commerce Protocol) | Google + 20+ ритейлеров | Полный lifecycle: discovery → checkout → post-purchase. Запущен на NRF 2026. |
| **AP2** (Agent Payments Protocol) | Google → FIDO Alliance | Cryptographically signed payment mandates. Передан в FIDO для нейтрального управления. |
| **A2A** (Agent-to-Agent) | Google → Linux Foundation | Coordination между разными агентами. Передан в Linux Foundation. |
| **x402** | Coinbase | Stablecoin-based agent payments. 165M транзакций в первые месяцы. |

### 5.2 Что изменилось за 9 месяцев (сентябрь 2025 → май 2026)

- **OpenAI deprecated Instant Checkout в марте 2026**. Только 8% попробовали, у дюжины Shopify merchants интегрировано, OpenAI не построил sales tax и fraud prevention.
- ACP теперь — **product discovery + merchant redirect**: агент рекомендует, покупатель идёт на сайт ритейлера. Это **наша модель**.
- UCP запущен Google на NRF 2026 при участии Shopify/Walmart/Target/20+. Powers Google AI Mode + Gemini app commerce.
- AP2 передан FIDO Alliance, A2A — Linux Foundation (нейтральное управление, не Google-only).
- MCP — де факто стандарт для tool-доступа.
- **Salesforce: $67B AI-influenced Cyber Week sales 2025**. Ритейлеры с AI agent integrations: **7× sales growth** vs. без.
- **Adobe: 805% YoY growth** в AI-driven retail traffic Black Friday 2025.

### 5.3 Применимость в РФ

- **Платёжный слой (ACP-native, AP2, x402)**: неприменим в РФ из-за санкций — Stripe, Adyen, Shopify Payments, stablecoin rails недоступны для российского merchant.
- **Discovery-слой (MCP, UCP product feed, ACP product feed)**: **применим**. Не требует платежей. Достаточно отдавать JSON-feed в нужном формате — агент рекомендует, покупатель заходит на сайт через redirect.
- **A2A**: ограниченно применим (если бренд хочет участвовать в multi-agent сценариях через нейтральных оркестраторов).

Для JCK AUTO в среднесрочной перспективе: **публиковать UCP/ACP-совместимый product feed на стороне discovery, payments оставлять через свою лид-форму и менеджеров**.

---

## 6. Технические требования для catalog-сайтов

Конкретно для inventory-based бизнесов (каталог авто, e-commerce магазин). JCK AUTO — этот класс.

### 6.1 Обязательный минимум schema

- **Vehicle / Product** на странице карточки — ✅ есть (после Wave A).
- **Offer** внутри Product — частично (имеется price, но не availability, не condition в строгом смысле).
- **AggregateRating + Review** — ❌ нет. Отзывы есть как контент, но без schema.
- **Organization** — частично, через layout-level LocalBusiness. Нужно расширить (founder, foundingDate, language, sameAs к Wikidata после создания).
- **FAQPage** — ✅ есть (после Wave A).
- **BreadcrumbList** — ✅ есть.
- **ItemList** на каталоге — ✅ есть.
- **HowTo** на статьях-инструкциях (растаможка, выбор аукциона) — ❌ нет.
- **WebSite** с SearchAction — обычно есть в layout, проверить.

### 6.2 Product API as customer interface

- Response time <200ms — чтобы агенты могли сравнивать в реальном времени.
- Все атрибуты, нужные для покупательского решения: id, brand, model, year, mileage, engine, transmission, drivetrain, color, condition, price, availability, location, photos.
- Открытый, без авторизации.
- JSON + machine-readable формат (`application/json`).
- `X-Robots-Tag: noindex, follow` — чтобы JSON не попадал в SERP, но crawl и link extraction работали.

### 6.3 Hero vs non-hero SKUs

Не все позиции каталога нужно оптимизировать одинаково. Разделение:

- **Hero** — топ-N машин (по марже, скорости продажи, узнаваемости модели). На них: полная Product+Offer+Review schema, расширенные описания, отзывы клиентов, история, фото высокого качества.
- **Non-hero** — остальной каталог. Минимальная Vehicle schema, базовое описание. Хватит для попадания в список «доступно у JCK», но не для глубокого AI-цитирования.

---

## 7. Статус JCK AUTO (snapshot 2026-05-24)

Текущее состояние по трём слоям. Обновляется по мере работ.

### 7.1 SEO foundation

| Компонент | Состояние |
|---|---|
| HTTPS, mobile-friendly, Core Web Vitals | ✅ |
| SSR для всех публичных страниц | ✅ (после Wave A промпт 06) |
| robots.txt с whitelist agentic endpoints | ✅ (после Wave A fix 2026-05-23) |
| XML sitemap + lastModified | ✅ |
| Backlinks profile, домен-авторитет | ⚠️ слабый, рост органический |

### 7.2 AEO layer

| Компонент | Состояние |
|---|---|
| FAQPage JSON-LD на карточках авто (5 Q&A) | ✅ (Wave A промпт 04) |
| Answer-first структура в SEO-статьях | ❌ нет правила в seoArticleGenerator.ts |
| Schema.org разметка (Vehicle, BreadcrumbList, ItemList) | ✅ (Wave A) |
| HowTo schema на статьях-инструкциях | ❌ нет |
| Date schema (`datePublished`, `dateModified`) | ⚠️ частично, не везде |

### 7.3 GEO layer

| Компонент | Состояние |
|---|---|
| llms.txt с описанием API surface | ✅ (Wave A + fix 2026-05-23) |
| Open JSON API (`/api/catalog`, `/api/catalog/[id]`, `/api/news`, `/api/reviews`, `/api/exchange-rates`) | ✅ |
| `@id` cross-surface (HTML + API) | ✅ (Wave A промпт 03) |
| Vehicle JSON-LD с `sameAs` на API | ✅ (Wave A промпт 03) |
| **Wikidata Q-ID JCK AUTO** | ❌ **нет** (критический gap) |
| **Wikipedia entry** | ❌ нет (notability ещё низкая, но Wikidata можно сейчас) |
| **Reddit / Pikabu / DTF / vc.ru / Drive2 / Drom forum presence** | ❌ нет систематического |
| **Co-citations в индустриальных roundup'ах** | ❌ нет |
| **GEO measurement ritual** | ❌ нет (только косвенный через Metrika UA-сегменты) |
| **Princeton-правила в контент-pipeline** (stats / quotes / front-load) | ❌ нет в seoArticleGenerator.ts |
| **Multilingual entity (EN, ZH)** | ❌ нет (только RU) |

### 7.4 Главные gap'ы по приоритету

1. **Wikidata Q-ID** — бесплатно, делается раз, кормит Knowledge Graph всех LLM. Самая дешёвая мера с самой большой отдачей.
2. **Measurement ritual** — без него мы не знаем стартовую точку. См. skill `ai-visibility-measurement-ritual`.
3. **GEO content rules в pipeline** — Princeton-правила в seoArticleGenerator.ts + articleReviewPrompt.ts. См. skill `geo-content-discipline`.
4. **Off-site presence** — Pikabu, DTF, vc.ru, Drive2, Drom forum participation. Долгая задача, см. `jck-auto/knowledge/roadmap/tasks/2026-05-24-off-site-brand-presence.md`.
5. **Schema-расширение** — Product+Offer+AggregateRating+Review поверх Vehicle, HowTo на статьях, Organization deep.

---

## 8. Authoritative sources

### 8.1 Академические работы

- Aggarwal, Vijaykumar, Yuksekgonul, Mahowald, Liang, Liang (Princeton + Georgia Tech + Allen AI + IIT Delhi). **GEO: Generative Engine Optimization.** KDD 2024. arxiv 2311.09735.
- Chen, Wang, Chen, Koudas. **Generative Engine Optimization: How to Dominate AI Search.** 2025. arxiv 2509.08919.
- Tian, Chen, Tang, Liu, Jia. **Diagnosing and Repairing Citation Failures in Generative Engine Optimization.** 2026. arxiv 2603.09296.
- Liu, Xu. **Think Before Writing: Feature-Level Multi-Objective Optimization for Generative Citation Visibility.** 2026. arxiv 2604.19113.
- Yuan, Wang, Wang, Sun, Wang, Li. **AgenticGEO: A Self-Evolving Agentic System for Generative Engine Optimization.** 2026. arxiv 2603.20213.
- Yu, Yang, Ding, Sato. **Structural Feature Engineering for Generative Engine Optimization.** 2026. arxiv 2603.29979.

### 8.2 Индустриальные исследования и гайды

**EN / Global:**
- Emilia Möller (independent GEO/SEO consultant) — LinkedIn webinar series, 2K+ register, 2025–2026.
- Brian Dean / Asif Ali (Backlinko). **Generative Engine Optimization (GEO): How to Win in AI Search.** Apr 2026.
- Profound. **97.4% AI citations from non-Tier-1 sources** study, 2026.
- Semrush AI Visibility Toolkit, 2026.
- Similarweb. **2026 Generative AI Brand Visibility Index.**
- eMarketer FAQ on GEO/AEO, April 2026.

**DE:**
- Lorenz Wacker (digitalagenten GmbH Berlin) — **Citation Economy** concept, 2025–2026.
- 121WATT, Aufgesang, smartlemon — guides 2026.
- SparkToro + Gumshoe.ai study **«LLM ответы не детерминированы»** (27 января 2026).

**FR:**
- Jérémy Lacoste (Eskimoz, France Num activator) — government-backed GEO guide.
- Natural-Net — **mentions vs citations** distinction.
- Semji (study 379 marketing pros, 2026): 63% планируют intensive GEO actions в 2026.
- Arcep Baromètre du numérique 2026 — 48% французов используют generative AI.

**RU:**
- Александр Тригуб (trigub.ru) — **5 требований Яндекс Нейро**, 2026.
- ODAA Studio, FedotovSEO, gpttext.ru — кейсы и playbook'и 2026.
- **Kokoc Performance** — исследование падения трафика инфо-ресурсов в 2025.

**CN:**
- 麦肯锡 (McKinsey) 2026 Generative AI Marketing Whitepaper — GEO services market +156% в 2026.
- 哈耶普斯, 百搜科技, 长尾矩阵 — GEO-агентства с DeepSeek/Doubao expertise.

### 8.3 Tooling

- Profound, Semrush AI Visibility, Ziptie.dev, Otterly, Visible, Conductor, SE Ranking AEO.
- Bing Webmaster Tools **AI Performance** (Microsoft, 10 февраля 2026) — первый GSC-аналог для AI.
- Discover (Yotpo) — e-commerce-specific AI visibility.

---

## 9. Changelog

- **2026-05-24 — v1.0.** Initial standard. Глоссарий SEO/AEO/GEO как трёх слоёв, эмпирические правила Princeton + 5 follow-up, метрики GEO, platform-specific механика (ChatGPT/Claude/Perplexity/Google AI/Yandex Neuro/DeepSeek/Doubao/Qwen), agentic commerce stack snapshot май 2026, технические требования для catalog-сайтов, JCK AUTO status snapshot, authoritative sources.
