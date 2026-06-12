---
name: geo-content-discipline
description: GEO/AEO content discipline — Princeton-rules applied at content authoring and review time. Use this skill whenever writing or reviewing any user-facing content destined for the web (SEO blog article, news digest, FAQ answer, car-card description, service-page copy, landing copy), planning a content pipeline change (seoArticleGenerator/articleReviewPrompt updates), or assessing existing content for AI-citation readiness. The skill encodes the seven Princeton-tier rules (Answer-first, ≥1 statistic per 300-word section, ≥1 quoted authority where possible, one idea per paragraph, conversational long-tail headings, ≤1 H2 as a question, Date schema), the platform-specific Yandex Neuro 5-of-30 constraint, and the schema-coverage checklist for catalog inventory pages. Mandatory in these situations — not optional. Do NOT use for internal documentation (ADRs, knowledge/*.md), prompt briefs to Claude Code, scripts/code comments, or operational chat replies — those are not GEO surfaces.
---

# GEO Content Discipline
<!--
  @file:        skills/geo-content-discipline/SKILL.md
  @description: Trigger-based content rules для AEO/GEO citation readiness:
                Princeton 7-rule set, Yandex Neuro 5-of-30, schema coverage,
                conversational long-tail. Reference fact-base — standards/ai-discovery-disciplines-standard.md.
  @version:     1.1
  @updated:     2026-06-12
-->

---

## 1. Philosophy

This skill is the **behavioral half** of GEO работы. Fact-base — `standards/ai-discovery-disciplines-standard.md` (далее «Стандарт»). Стандарт говорит **что такое** SEO/AEO/GEO и что эмпирически работает; этот skill говорит **когда и как** применять правила на конкретной странице.

Триггерится при создании или ревью контента для web-surface бренда. Не триггерится для внутренней документации, кода, операционных сообщений.

**Один принцип перекрывает остальные**: пишем контент так, чтобы LLM могла **вытащить готовый ответ** (extraction) и **процитировать** (trust). Если фраза в статье не extractable как самостоятельный ответ — это потенциально потерянное цитирование.

---

## 2. Scope

### In scope (skill активируется)

- SEO blog articles (`content/blog/**`)
- News digests (`content/news/**`)
- Car-card descriptions (`description`, `summary` поля в catalog.json и в `seoArticleGenerator.ts` для генерации)
- FAQ answers (FAQPage JSON-LD payload, секции на статических страницах)
- Service-page copy (`/about`, `/tools/*`, landing-блоки)
- Любой контент, попадающий в `public/` и доступный crawler'у

### Out of scope

- ADRs, knowledge/*.md, internal docs
- Прямые сообщения Vasily в чате (это операционная коммуникация)
- Claude Code prompts (это инструкции исполнителю, не surface)
- Скрипты, конфиги, code comments
- Telegram-каналы и DM (отдельные surfaces со своими правилами)

Если непонятно: «попадает ли этот текст в `public/` или будет проиндексирован?» Если да — in scope.

---

## 3. Activation Triggers

Skill активируется автоматически, когда:

### Trigger 1 — Создаётся новая SEO-статья / новость / FAQ-блок
Это «горячий» trigger — каждая новая web-страница проходит через эти правила перед публикацией.

### Trigger 2 — Меняется системный промпт generation/review pipeline
`src/services/articles/seoArticleGenerator.ts`, `articleReviewPrompt.ts`, генератор тизеров для Telegram-каналов, любые промпты в `src/services/news/`.

### Trigger 3 — Vasily просит «улучшить статью» / «переписать описание»
Любой запрос на ревизию существующего user-facing контента.

### Trigger 4 — Создаётся новая landing-секция / about-блок / service page
Не только статьи — любые публичные текстовые блоки.

### Trigger 5 — Чек существующего контента на «AI-citation readiness»
Когда Vasily спрашивает «как у нас с AI-видимостью статьи Х?» — skill даёт чеклист для аудита.

### Не trigger

- Vasily пишет «поправь опечатку в статье» — это T1, GEO-правила не пересматриваем.
- Vasily пишет «обнови дату публикации» — `dateModified` это GEO-rule №7, но триггерится автоматом при изменении контента, отдельного skill-применения не требует.
- Внутренний knowledge update — не surface.

---

## 4. The Seven Princeton-tier Rules

Источник: Princeton GEO paper (arxiv 2311.09735) + 5 follow-up academic papers 2025–2026 + Backlinko 2026 guide. Полная фактура — Стандарт §2.

Эти семь правил применяются **вместе**, не выборочно. Каждое — это рычаг lift'а citation visibility.

### Rule 1 — Answer-first структура

Главный ответ на вопрос секции — в **первых 30–60 словах** после H2. Не введение, не контекст — сразу суть.

**Плохо:**
> ## Растаможка автомобиля из Кореи
> Многие задумываются о покупке корейских автомобилей. Это популярный тренд последних лет, особенно после изменений в логистике. В нашей статье мы рассмотрим...

**Хорошо:**
> ## Растаможка автомобиля из Кореи
> Растаможить автомобиль из Кореи в 2026 году стоит от 500 000 до 2 500 000 рублей в зависимости от объёма двигателя, возраста и мощности. Базовая ставка пошлины — 20% от стоимости для авто младше 3 лет с двигателем до 1500 см³. Утильсбор — от 3 400 рублей (новые) до 5 200 рублей (б/у).

LLM extractable. Перевод в featured snippet и AI Overview — прямой.

### Rule 2 — ≥1 конкретная статистика на каждые 300 слов секции

Princeton lift: **+30–32%** visibility за статистики. Числа должны быть конкретные, проверяемые, со ссылкой на источник или с пометкой «расчёт JCK AUTO».

**Плохо:** «растаможка обходится недёшево»
**Хорошо:** «средняя стоимость растаможки Hyundai Sonata 2020 на VDS-калькуляторе JCK AUTO за май 2026 — 1 240 000 ₽»

### Rule 3 — ≥1 цитируемый авторитет, где возможно

Princeton lift: **+41%** visibility за добавление quotations. Применимые источники для JCK AUTO:

- Постановления Правительства РФ (растаможка, утильсбор)
- ФТС России (тарифы, регламент)
- Минпромторг (списки моделей, утильсбор)
- Минфин (валютный контроль)
- Центральный банк РФ (курсы валют)
- Росстандарт (сертификация)
- Производитель (Hyundai, Kia, Toyota — официальные спецификации)

Цитата — короткая, точная, со ссылкой на источник: «Согласно Постановлению Правительства РФ № 1457 от 26.12.2025 (актуально на 2026), утилизационный сбор для физических лиц...»

### Rule 4 — One idea per paragraph

Один абзац — одна идея. Короткие абзацы 2–4 предложения. LLM режут контент на chunks; один chunk = одна идея = одна extractable unit.

**Плохо** (3 идеи в одном абзаце):
> Растаможка из Кореи дешевле, чем из Японии, потому что Корея ближе и логистика короче. Также стоит учесть, что в Корее много дилеров, готовых работать на экспорт, тогда как Япония требует посредника-аукциониста. Плюс, корейские машины менее изношены за счёт лучших дорог.

**Хорошо**:
> Логистика из Кореи короче, чем из Японии: путь Пусан → Владивосток занимает 3–5 дней против 7–10 для Японии. Это сокращает стоимость доставки на 15–20%.
>
> Корейские дилеры готовы работать на экспорт напрямую. В Японии экспортный канал идёт через аукционы (USS, TAA, Honda), что добавляет 5–8% к цене из-за комиссии посредников.
>
> Состояние корейских машин в среднем лучше за счёт качества дорог. Средний пробег при импорте — 80 000 км против 120 000 км для Японии (данные JCK AUTO за 2024–2025).

### Rule 5 — Conversational long-tail headings

Заголовки H2/H3 формулируются как **вопросы пользователя в natural language**, не как сухие SEO-ярлыки.

**Плохо:** «Растаможка из Кореи»
**Хорошо:** «Сколько стоит растаможить машину из Кореи в 2026 году»

**Плохо:** «Документы для импорта»
**Хорошо:** «Какие документы нужны для растаможки авто из Японии»

Это совпадает с тем, как пользователи реально задают вопросы в ChatGPT / Yandex Neuro / Perplexity (60-словные запросы в среднем для ChatGPT, vs 3.4-словные для Google).

### Rule 6 — ≤1 H2 как вопрос на статью

Это **anti-pattern detection**: если ВСЕ H2 — вопросы, AI flags статью как over-optimized. Естественная статья имеет смесь: 1–2 H2-вопроса как «якорные» для AI extraction, остальные H2 — нейтральные.

**Хорошо:**
> ## Сколько стоит растаможка из Кореи в 2026 *(H2-вопрос — anchor)*
> ## Этапы процесса *(нейтральный)*
> ## Документы *(нейтральный)*
> ## Калькулятор JCK AUTO *(нейтральный)*

**Плохо:**
> ## Сколько стоит растаможка?
> ## Какие документы нужны?
> ## Как долго это занимает?
> ## Что нужно подготовить?
*(over-optimized — все H2 это вопросы)*

### Rule 7 — Date schema на каждой статье

`datePublished` + `dateModified` обязательны в JSON-LD каждой публичной статьи. **85% AI Overview citations — из контента не старше 2 лет** (Seer Interactive 2025). Свежий контент цитируется в **4.3 раза чаще** устаревшего.

Применение в JCK AUTO:
- В `articlePublisher.ts` — `dateModified` обновлять при каждом изменении контента (не только публикации).
- В Vehicle JSON-LD — `dateModified` для карточек авто (когда менялась цена, описание).
- В layout/structured-data — для статической Organization schema `foundingDate`.

---

## 5. Yandex Neuro 5-of-30 constraint

Критично для JCK AUTO — основной канал в РФ. Полная механика в Стандарте §4.5.

**Yandex Neuro берёт ровно 5 источников из топ-30 органической выдачи.** Условие №1 — попадание в топ-30 классическим SEO. Остальные четыре требования (Стандарт §4.5):

1. E-E-A-T сигналы (экспертный автор, идентифицируемая организация)
2. Техническая структура (Schema.org, semantic HTML)
3. AEO-формат ответа (Answer-first, первый абзац — суть)
4. Актуальность (свежий `dateModified`, регулярное обновление)
5. Уникальные данные (свои числа, кейсы, расчёты — не пересказ)

**Practical implication для контента:**

- Каждая SEO-статья должна иметь **named expert author** (не «admin», не пусто). Для JCK AUTO — Vasily, Andrey, либо collective «команда JCK AUTO» с ссылкой на `/about`.
- Organization schema на странице — обязательна (через layout).
- Принцип «уникальные данные»: статья без своих чисел = пересказ конкурентов = не будет процитирована. **Свои расчёты, свои кейсы, свои цифры — это критерий цитируемости.**

---

## 6. Schema coverage для catalog inventory pages

Для JCK AUTO как catalog-сайта (не блог-сайта). Полная карта — Стандарт §6.

> **Честная рамка про schema.** Структурированные данные — это **connective tissue для RAG-grounding и entity-понимания**, а не «магия цитирования». Schema не покупает цитату и не поднимает ранжирование напрямую; она помогает машине надёжно считать факты страницы и связать сущности. Из этого следуют два правила, которые важнее «навесить побольше типов»: (1) **parity** — размечаем только то, что реально видно на странице (расхождение markup↔видимый контент трактуется как spammy structured data; механика и валидация — в `structured-data-discipline`); (2) валидный и честный markup ценнее обширного. Ниже — что покрывать; *как* это валидировать и держать parity — в `structured-data-discipline`.

### 6.1 Обязательный минимум на странице товара (`/catalog/cars/{id}`)

- **Vehicle** ✅ есть (после Wave A)
- **Offer** внутри Vehicle — частично; нужно расширить: `availability`, `priceCurrency`, `priceValidUntil`, `itemCondition`
- **BreadcrumbList** ✅ есть
- **FAQPage** ✅ есть (Wave A промпт 04)

### 6.2 Желательное расширение (TD-GEO-SCHEMA-1)

- **AggregateRating + Review** — у нас есть отзывы как контент, но без schema. Это блокирует цитирование «отзывы о JCK AUTO» промптов.
- **Product** поверх Vehicle (Vehicle — это специализация Product) — расширяет совместимость с e-commerce агентами.

### 6.3 Для статей-инструкций (`/blog/*`)

- **Article** ✅ обычно есть
- **HowTo** на инструкциях типа «как растаможить» — **больше НЕ добавляем как новый markup**. Google ретайрнул HowTo rich result (раньше FAQ), и как поисковый rich-result он мёртв. Если HowTo уже стоит — не самоцель удалять, но новые статьи в нём не размечаем; пошаговость лучше передать обычной структурой (нумерованные H3 / списки в Article) — это и людям, и LLM-extraction даёт то же, без ставки на исчезнувший rich-result.
- **FAQPage** в конце статьи для вопросов-ответов — ✅ паттерн Wave A сохраняем, но с правильным ожиданием: **FAQ rich result в выдаче Google ретайрнут (2026-05-07; удаление FAQ-данных из Search Console API — август 2026).** FAQPage теперь работает не на SERP-«звёздочки», а как **entity/RAG-grounding и voice/AI-источник** — структурированная Q&A помогает LLM вытащить готовый ответ. Размечаем только реально видимые на странице Q&A (parity — см. `structured-data-discipline`), не ради rich-result, а ради extractability.

### 6.4 Organization deep schema (global, в layout)

Текущая `LocalBusiness` в layout — минимальная. Расширение:
- `foundingDate`
- `founder` (Person с указанием Vasily / Andrey)
- `numberOfEmployees`
- `slogan`
- `knowsAbout` (массив тем: «car import from China», «customs clearance Russia», «used car inspection»)
- `sameAs` (массив — сейчас Telegram/Instagram/YouTube; после создания Wikidata Q-ID — добавить туда)
- `inLanguage`: `"ru"` сейчас; при появлении EN-зеркала — отдельная Organization entity с тем же `sameAs`-набором.

---

## 7. Anti-patterns — что AI флагает и режет цитирование

Источник: DeepSeek фильтры 2026 (Стандарт §4.6), Yandex Neuro качественные сигналы (Стандарт §4.5), общий GEO consensus.

### Anti-pattern 1 — Keyword stuffing
Повторение целевого ключа более 3–4 раз на статью 1000 слов. DeepSeek и Yandex Neuro распознают и снижают приоритет.

### Anti-pattern 2 — Шаблонные ranking-lists без своих данных
«Топ-10 лучших импортёров авто 2026» без собственного исследования = AI-флаг «однородный контент». Если делаем roundup — добавляем свои критерии оценки, свои числа, свой кейс.

### Anti-pattern 3 — «Простыня» текста без структуры
Сплошной текст без H2/H3, без списков, без таблиц — не extractable. Один абзац-простыня → не процитируют.

### Anti-pattern 4 — Все H2 — вопросы
См. Rule 6. Over-optimization detection.

### Anti-pattern 5 — Subjective adjectives без чисел
«Удобный», «надёжный», «лучший», «быстрый», «качественный» без backing цифрами = маркетинговый шум, AI игнорирует. Заменяем: «удобный» → «срок доставки 14 дней против среднерыночных 21», «надёжный» → «гарантия завода до 2 лет на отобранные модели».

### Anti-pattern 6 — Старый `dateModified` при свежем контенте
Если контент обновлён, а `dateModified` остался 2024-го года — AI считает контент устаревшим и снижает приоритет (4.3× деградация цитирования по Seer).

### Anti-pattern 7 — Anonymous authorship
Статья без named author = понижение E-E-A-T = Yandex Neuro не цитирует. Минимум — `author` поле с именем (Vasily / Andrey / «команда JCK AUTO» + link на `/about`).

---

## 8. Application — что делать при триггере

### При создании новой статьи (Trigger 1)

Перед публикацией прогнать 9-пункт checklist:

1. ✅ **Answer-first**: первый абзац после H2 содержит готовый ответ (30–60 слов).
2. ✅ **Statistics**: минимум 1 конкретное число с источником на каждые 300 слов.
3. ✅ **Quoted authority**: минимум 1 цитата гос. источника / производителя / собственного расчёта JCK.
4. ✅ **One idea per paragraph**: проверить, что в каждом абзаце ровно одна идея.
5. ✅ **Conversational headings**: H2 сформулированы как реальные вопросы пользователя.
6. ✅ **≤1 H2 как вопрос**: проверить, что не все H2 — вопросы.
7. ✅ **Date schema**: `datePublished` + `dateModified` в frontmatter / в JSON-LD.
8. ✅ **Named author**: `author` поле заполнено, не anonymous.
9. ✅ **Schema coverage**: Article + (FAQPage где есть реальные видимые Q&A) + BreadcrumbList. HowTo как rich-result больше не цель (§6.3); пошаговость — обычной структурой.

Если хоть один пункт ❌ — статья не публикуется до исправления.

### При изменении content pipeline (Trigger 2)

Системные промпты `seoArticleGenerator.ts`, `articleReviewPrompt.ts` должны содержать все 7 правил в виде явных инструкций модели. Когда меняем pipeline — проверяем, что новая версия промпта **не теряет ни одного из 7 правил**.

### При запросе аудита существующего контента (Trigger 5)

Прогнать тот же 9-пункт checklist + дополнительно:

10. ✅ **Anti-patterns absent**: 7 anti-patterns из §7 не присутствуют.
11. ✅ **Yandex Neuro readiness**: статья в топ-30 органики по своему ключу (проверка через Yandex Webmaster).
12. ✅ **AI-citation test**: прогнать целевой запрос статьи через ChatGPT / Claude / Perplexity / Yandex Neuro и проверить, цитируется ли JCK AUTO. Если нет — диагностический разбор (см. skill `ai-visibility-measurement-ritual`).

---

## 9. Boundary cases — когда правила гнутся

### Case 1 — Корпоративная новость / анонс
Короткая новость на 200–300 слов (новое поступление, изменение тарифов) не требует ≥1 статистики на 300 слов, но требует свежий `dateModified` и named author. Применяем Rules 4, 5, 7, 8; Rules 2 и 3 — если контент позволяет.

### Case 2 — Карточка автомобиля
Описание машины — не статья. Применяем: Rule 4 (one idea / paragraph для секций описания), Rule 7 (`dateModified` через `lastUpdated`), Vehicle+Offer schema (§6.1). Rules 1, 2, 3, 5, 6 — не релевантны (нет H2-структуры).

### Case 3 — FAQ-блок на статической странице
Q&A пары — применяем Rule 1 (Answer-first — это сама природа FAQ), Rule 7 (Date schema через статью-родителя), FAQPage schema. Остальные — по ситуации.

### Case 4 — Vasily явно просит «давай без статистики, просто вступление»
Tone choice over GEO. Skill отступает, но **отмечает** в ответе: «правила Princeton не применены, AI-видимость этой страницы будет ниже». Это honest trade-off, не avoidance.

---

## 10. Self-check questions

Когда пишешь / ревьюишь контент, прогоняй:

| Сомнение | Вопрос |
|---|---|
| Этот текст вообще попадает под GEO? | Этот контент будет в `public/` или попадёт в crawler? Если да — да. |
| Слишком сухо со статистикой? | Princeton lift +30–41% от statistics+quotes; если статистики 0 — лифт 0. Лучше сухо и цитируется, чем «литературно» и игнорируется. |
| Заголовки звучат странно как вопросы | Это естественная формулировка реального пользовательского запроса? Если да — оставляй. |
| Не слишком ли мы Yandex-центричны | Yandex Neuro — основной канал РФ-аудитории. ChatGPT/Claude используют те же сигналы (Answer-first, schema, fresh date). Это не trade-off — это совпадение требований. |
| Можно ли удалить мне эту статистику? | Если убрать число и заменить на «много» / «значительно» — ответ не extractable. Цифра нужна для extraction. |

---

## 11. Connections to other skills

- **`page-optimization-orchestrator`** — входная дверь серии SEO+GEO. Когда оптимизируется страница, оркестратор классифицирует её и делегирует **текстовый слой** сюда; этот skill возвращает свой gate-результат. Если работа пришла через оркестратор — он решает, какие ещё слои нужны.
- **`page-technical-seo`** — технический слой-сосед (title/meta/canonical/индексируемость/CWV). Контент не цитируется, если страница не индексируется: «нет индексации → нет извлечения → нет цитаты». Этот skill отвечает за текст, тот — за обёртку.
- **`structured-data-discipline`** — владеет **механикой и валидностью schema** (JSON-LD shape, parity, entity-глубина, freshness, llms.txt). Этот skill говорит, какой контент должен быть размечен и почему (§6), но *как* размечать/валидировать и держать parity — там. FAQ/HowTo-статус (§6.3) синхронизирован с тем скиллом.
- **`agentic-commerce-readiness`** — для карточек товара (Case 2): consumer-readable нарратив (этот skill) должен согласовываться с agent-readable атрибутами (тот skill); двухслойность товара требует, чтобы текст и computable-атрибуты не противоречили.
- **`prompt-writing-standard`** — Step 9 multi-perspective review: при ревью промпта, который пишет контент-генератор (seoArticleGenerator updates), Content Editor reviewer прогоняет 9-пункт checklist из §8.
- **`ai-visibility-measurement-ritual`** — пара. Этот skill оптимизирует контент **на write-side**, тот — измеряет результат **на read-side**.
- **`knowledge-structure`** — не пересекается. Knowledge файлы (`knowledge/*.md`) — internal, не surface, скилл там не применяется.
- **`real-path-verification`** — если правило применяется к контенту, который будет рендериться в production: после публикации проверить через ChatGPT/Perplexity, цитируется ли. Это real-path verification GEO-эффекта.

---

## 12. Reference

Полная фактура — `vibecoding-workspace/standards/ai-discovery-disciplines-standard.md`:
- §2 Эмпирические правила (Princeton + follow-up)
- §3 Метрики GEO/AEO
- §4 Platform-specific механика (включая Yandex Neuro 5-of-30)
- §6 Технические требования для catalog-сайтов
- §7 JCK AUTO status snapshot

При расхождении этого skill и Стандарта — Стандарт авторитетнее.

---

## 13. Changelog

- **2026-06-12 — v1.1.** Surgical update (4 согласованных правки, 3 применены). (а) §6.3/§8: фикс устаревшего HowTo/FAQ-rich-result — HowTo и FAQ rich results ретайрнуты Google (FAQ 2026-05-07, API-removal авг 2026); FAQPage переориентирован на entity/RAG-grounding и voice/AI, не на SERP-«звёздочки»; новые статьи HowTo-markup не используют. (б) §6: добавлена честная рамка «schema = connective tissue для RAG-grounding, не магия цитирования» с акцентом на parity и валидность. (г) §11: добавлены связи с 4 скиллами серии (page-optimization-orchestrator, page-technical-seo, structured-data-discipline, agentic-commerce-readiness). Правка (в) [car-card contradiction] снята как неактуальная — в v1.0 противоречия нет, description и тело согласованы. Princeton-правила, Yandex Neuro 5-of-30, anti-patterns, checklist — без изменений.
- **2026-05-24 — v1.0.** Initial skill. Seven Princeton-tier rules, Yandex Neuro 5-of-30 application, schema coverage для catalog inventory, 7 anti-patterns, 9-пункт checklist для новых статей, boundary cases, self-check questions.
