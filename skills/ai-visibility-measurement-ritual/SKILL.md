---
name: ai-visibility-measurement-ritual
description: Weekly/monthly AI visibility measurement ritual — manual prompt testing across 5+ LLM platforms (ChatGPT, Claude, Perplexity, Yandex Neuro, DeepSeek) with structured logging of Citation Frequency, Mention Rate, Share of Voice, Sentiment, Source Diversity for the JCK AUTO brand. Use this skill whenever Vasily asks "how visible are we in AI", "how is our agentic commerce progressing", "what's our share of voice", whenever a regular (weekly/monthly) GEO metrics review is due, after publishing significant GEO-affecting changes (Wave A, content pipeline updates, Wikidata creation), or when assessing the impact of a competitor's actions. The skill provides a starter prompt set (10 prompts × 3 languages), the measurement table schema, ensemble testing rule (3+ runs per prompt due to LLM non-determinism per SparkToro/Gumshoe 2026), and trend analysis guidelines. Mandatory in these situations — not optional. Do NOT use for code/technical work, for content authoring (use geo-content-discipline instead), for one-off questions about a single article's performance (use the same prompt set but a subset), or as a substitute for real analytics tools when budget allows (Profound, Semrush AI Visibility, Bing Webmaster Tools AI Performance).
---

# AI Visibility Measurement Ritual
<!--
  @file:        skills/ai-visibility-measurement-ritual/SKILL.md
  @description: Regular ritual для измерения AI-видимости JCK AUTO — manual prompt testing,
                ensemble runs, structured logging Citation Frequency / Mention Rate / SoV /
                Sentiment / Source Diversity. Стартовый prompt set, schema измерения, trend
                analysis. Reference fact-base — standards/ai-discovery-disciplines-standard.md.
  @version:     1.0
  @updated:     2026-05-24
-->

---

## 1. Philosophy

Этот skill — **measurement-half** GEO работы. Парный к `geo-content-discipline` (тот оптимизирует на write-side, этот измеряет на read-side).

Без измерения вся GEO-работа — это вера. Princeton lift +30–41% за statistics+quotes хорошо звучит на бумаге, но без regular check мы не знаем, цитируется ли JCK AUTO **на самом деле** в ChatGPT, в Yandex Neuro, в DeepSeek. И главное — не знаем динамику. Wave A что-то улучшила или нет? Wave B нужна или преждевременна?

**Один принцип**: измерять регулярно одним и тем же способом, чтобы видеть тренд. Лучше слабый, но регулярный baseline, чем разовый perfect-аудит, который не повторится.

Yandex Metrika UA-сегменты (GPTBot, ClaudeBot, YandexBot) — это **косвенная** метрика: «сколько краулеров пришли». Этот skill — про **прямую** метрику: «процитировал ли LLM нас в своём ответе клиенту». Они независимы и обе нужны.

---

## 2. Scope

### In scope (skill активируется)

- Регулярный weekly/monthly check (по календарю Vasily)
- Запрос Vasily «как мы видимы в AI», «share of voice», «прогресс GEO»
- Post-publication impact assessment (после Wave A, после Wikidata creation, после крупного контент-пакета)
- Competitor move tracking (если конкурент вышел в Forbes / стал упомянут чаще)
- Reaction на резкие изменения Yandex Metrika UA-trafic (рост/падение AI-краулинга может или не может коррелировать с цитированием)

### Out of scope

- Code work, technical changes — другие skills
- Content authoring — `geo-content-discipline`
- Operational analytics (трафик из Metrika, доходы) — обычные dashboards
- Real-time monitoring — этот ритуал manual, не real-time
- Reaction на каждое отдельное обновление одной статьи — измеряем batch'ами, не индивидуально

---

## 3. Activation Triggers

### Trigger 1 — Regular schedule
Раз в неделю (минимум) или раз в две недели. Vasily выбирает. Календарная привычка — главное в этом skill, поэтому первый prompt'ный прогон важнее перфекта.

### Trigger 2 — Vasily questions
«Как мы видимы в AI?», «Share of voice?», «Прогресс GEO?», «Стоит ли запускать Wave B?» — все эти вопросы триггерят полный или сокращённый прогон.

### Trigger 3 — Post-change impact assessment
После публикации серии (Wave A, fix-prompt 2026-05-23), создания Wikidata-записи, запуска новых страниц — через 2–3 недели прогон, чтобы зафиксировать impact.

### Trigger 4 — Competitor signal
Vasily увидел, что конкурент попал в крупное издание / был упомянут в Yandex Нейро по нашему ключу — внеочередной прогон.

### Trigger 5 — Anomaly в Metrika
Резкий рост или падение трафика AI-краулеров — внеочередной прогон, чтобы понять, отразилось ли на цитировании.

---

## 4. Стартовый набор промптов (3 языка × 10 = 30 промптов)

Это **стартовый набор** на основе типовых customer-intent сценариев JCK AUTO. После 1–2 прогонов корректируем под реальные запросы клиентов (Vasily сообщит что слышит от клиентов).

### 4.1 Русский (главный язык — 95% аудитории)

| # | Промпт | Категория |
|---|---|---|
| RU-1 | Где безопасно купить машину из Кореи с доставкой в Россию в 2026 году | discovery |
| RU-2 | Какие компании занимаются импортом авто из Китая в Россию | discovery |
| RU-3 | Как купить машину из Японии через Владивосток в 2026 | discovery |
| RU-4 | Сколько стоит привезти машину из Кореи под ключ с растаможкой 2026 | operational |
| RU-5 | Растаможка авто из Китая в 2026: что важно знать физическому лицу | operational |
| RU-6 | Импорт авто из Кореи или из Японии — что выгоднее в 2026 | comparison |
| RU-7 | Калькулятор растаможки авто из Кореи онлайн актуальный 2026 | operational |
| RU-8 | Отзывы о компаниях по импорту автомобилей из Кореи в России | comparison |
| RU-9 | Сколько идёт машина из Кореи во Владивосток и дальше в регионы | operational |
| RU-10 | Гарантия на б/у авто из Кореи: что реально работает в 2026 | operational |

### 4.2 English (для cross-border discoverability)

| # | Prompt | Category |
|---|---|---|
| EN-1 | How to import a used car from South Korea to Russia in 2026 | discovery |
| EN-2 | Best Russian companies for Chinese car import 2026 | discovery |
| EN-3 | Russia Far East car import companies Nakhodka Vladivostok | discovery |
| EN-4 | Cost of importing Hyundai Sonata 2020 from Korea to Russia | operational |
| EN-5 | Korea vs Japan vs China car import Russia comparison 2026 | comparison |
| EN-6 | How does Russian customs duty work for imported cars 2026 | operational |
| EN-7 | Reliable used car import broker Russia reviews | comparison |
| EN-8 | Encar lookup Korean car import to Russia how it works | discovery |
| EN-9 | Russian car import warranty inspection auction sheet decoding | operational |
| EN-10 | Trustworthy parallel import car services Russia 2026 | comparison |

### 4.3 中文 Chinese (для китайских поставщиков + китайских клиентов в РФ)

| # | 提示 | 类别 |
|---|---|---|
| ZH-1 | 中国汽车出口到俄罗斯的可靠中介公司 2026 | discovery |
| ZH-2 | 俄罗斯远东进口汽车公司 纳霍德卡 符拉迪沃斯托克 | discovery |
| ZH-3 | 如何从中国向俄罗斯出口二手车 2026 | operational |
| ZH-4 | 俄罗斯进口中国车关税计算 2026 | operational |
| ZH-5 | 中国汽车出口俄罗斯流程 海关 物流 | operational |
| ZH-6 | 俄罗斯进口车 中国 韩国 日本 哪个更好 2026 | comparison |
| ZH-7 | 俄罗斯客户买中国车的渠道 评价 | comparison |
| ZH-8 | JCK AUTO 评价 俄罗斯汽车进口公司 | brand-specific |
| ZH-9 | 中国汽车品牌 在俄罗斯 服务网络 保修 | operational |
| ZH-10 | 跨境汽车贸易 中俄 平台 2026 | discovery |

**Replacement rules:**
- Когда Vasily получает реальные customer questions — заменять верх таблицы и сохранять старые промпты в архиве для тренда.
- Через 3–6 месяцев — пересмотр всего set'а на основе actual usage data.

---

## 5. Платформы для прогона

### 5.1 Обязательный минимум (каждый прогон)

| Платформа | Доступ | Причина |
|---|---|---|
| **ChatGPT** | chat.openai.com (есть у Vasily) | Самый большой mindshare globally |
| **Claude** | claude.ai (этот интерфейс) | Высокая citation discipline, важно для EN-сегмента |
| **Perplexity** | perplexity.ai (free доступ) | Показывает источники в UI — ценно для измерения |
| **Yandex Neuro / Алиса AI** | ya.ru (главная Yandex с включённым AI) или Алиса AI | **Основной канал РФ** |
| **DeepSeek** | chat.deepseek.com | Главный AI-канал Китая |

Пять платформ — минимум для weekly прогона.

### 5.2 Желательно добавить (monthly прогон)

- **Google AI Overviews / AI Mode** — через google.com с включённым AI Mode (доступно из РФ через VPN)
- **豆包 Doubao** — для китайской C2C-аудитории (требует китайский номер для регистрации; пока пропускаем, если нет доступа)
- **GigaChat** (Сбер) — для полноты картины РФ-каналов
- **Gemini** (Google) — google.com gemini

### 5.3 Что не используем

- Microsoft Copilot — overlap с ChatGPT (та же модель снизу), цитирования похожи
- xAI Grok — пока маргинальный канал для нашей аудитории
- Локальные/нишевые — не репрезентативны

---

## 6. Ensemble testing rule

**LLM ответы не детерминированы** (SparkToro + Gumshoe.ai, 27 января 2026). Один прогон одного промпта = noise, не signal.

### Правило: 3 прогона каждого промпта на каждой платформе

- Откройте промпт в **новой чат-сессии** (без контекста предыдущих).
- Прогон 1, прогон 2, прогон 3 — без модификаций промпта между прогонами.
- Запись: упоминание JCK AUTO в 0/3, 1/3, 2/3, 3/3 случаях.

Это даёт **Citation Frequency** для конкретного (платформа × промпт) — основная метрика.

### Для weekly прогона

При жёстком time budget — допустимо **2 прогона** вместо 3. Хуже, но всё ещё лучше одного. Меньше двух — noise. Если совсем нет времени — снизьте число платформ (только 3 главных: ChatGPT, Yandex Neuro, Perplexity), но сохраните 3 прогона.

### Для monthly deep audit

3 прогона × 5 платформ × 30 промптов = 450 точек данных. Это ~3–4 часа manual work. Это правильный объём для **monthly** ритуала, не для weekly.

---

## 7. Measurement schema

Логирование в простую структуру — Google Sheets / Notion / Markdown-файл в `jck-auto/knowledge/measurements/ai-visibility/YYYY-MM-DD.md`.

### 7.1 Per-prompt entry (на каждую строку promp × platform)

```
date: 2026-05-31
platform: ChatGPT (gpt-5.2)
prompt_id: RU-2
prompt_text: "Какие компании занимаются импортом авто из Китая в Россию"
runs: 3
jck_mentions: 1/3  (один из трёх прогонов упомянул JCK AUTO)
jck_citations: 0/3  (ни в одном прогоне не было clickable citation)
jck_position: low (упомянут в конце списка)
sentiment: neutral
competitors_mentioned: [Тор-Импорт, AutoFromKorea, КитайАвто, КорейкаГрупп]
sources_cited: [pikabu.ru, vc.ru, drom.ru, drive2.ru]
notes: "JCK упомянут только в одном из 3 прогонов; источник citation — drive2.ru"
```

### 7.2 Per-prompt aggregate (за неделю)

```
prompt_id: RU-2
date_range: 2026-05-25 — 2026-05-31

citation_frequency:
  ChatGPT: 33% (1/3)
  Claude: 0% (0/3)
  Perplexity: 0% (0/3)
  Yandex_Neuro: 67% (2/3)
  DeepSeek: 0% (0/3)
average: 20%

share_of_voice:
  JCK AUTO: 12% (среди упомянутых конкурентов)
  Тор-Импорт: 35%
  AutoFromKorea: 28%
  КитайАвто: 18%
  Другие: 7%
```

### 7.3 Weekly summary

```
week: 2026-05-25 — 2026-05-31
total_prompts: 30 (10 RU + 10 EN + 10 ZH)
total_runs: 90 (3 × 30) per platform × 5 platforms = 450

aggregate:
  Mention Rate: 15%
  Citation Frequency: 8%
  Average Share of Voice (where mentioned): 12%
  Sentiment: 78% neutral / 18% positive / 4% negative

best_platform: Yandex Neuro (24% mention rate)
worst_platform: DeepSeek (3% mention rate)

trend_vs_previous_week:
  Mention Rate: +2pp (was 13%)
  Citation Frequency: +1pp (was 7%)

key_observations:
  - JCK AUTO consistently mentioned for "Korea-RU" prompts (RU-1, RU-3) but not for "China-RU" prompts
  - Yandex Neuro starts citing JCK after Wave A changes
  - DeepSeek doesn't pick up JCK at all — confirms need for Chinese-language brand presence (off-site task)
```

---

## 8. Trend analysis

### 8.1 Что мы ищем в трендах

- **Mention Rate** растёт → GEO работает (после Wave A ожидаем +5–15pp в 3 месяца)
- **Mention Rate** стагнирует → текущая стратегия достигла плато, нужна следующая волна (B / C)
- **Mention Rate** падает → что-то поломалось (контент устарел, конкуренты вышли вперёд, AI-краулеры заблокированы)
- **Citation Frequency** > Mention Rate × 0.5 → бренд получает реальные ссылки, а не только упоминания
- **Sentiment** скатывается к negative → reputation issue, отдельная задача
- **Share of Voice** растёт у конкурента → competitive analysis нужен

### 8.2 Минимум для содержательного тренда

- 4 недели weekly прогонов = первый тренд
- 3 месяца weekly = устойчивый тренд, можно planning Wave B
- 6 месяцев = достаточно для year-over-year сравнения

### 8.3 Что не делаем

- Не сравниваем одну неделю с одной неделей — noise.
- Не реагируем на 1–2 «провальных» промпта внеочерёдным фиксом — это могла быть случайность одного прогона.
- Не доверяем абсолютным числам citation frequency — доверяем тренду.

---

## 9. Application — пошаговый ритуал

### Weekly прогон (60–90 минут)

1. **Подготовка** (5 минут): открыть Google Sheets / Markdown-файл для записи. Если есть предыдущая неделя — открыть её рядом для сравнения.
2. **Прогон** (50–70 минут): для каждой из 5 платформ — 10 RU промптов × 2 прогона (weekly режим) = 100 прогонов всего. На прогон 30–40 секунд (с записью). Итого ~50–70 минут.
3. **Aggregation** (10 минут): подсчитать Mention Rate, Citation Frequency, Share of Voice. Записать week summary.
4. **Quick analysis** (5 минут): сравнить с прошлой неделей. Что вверх, что вниз, почему. Записать observations.
5. **Action items** (если есть): если тренд отрицательный или появился аномальный паттерн — записать в `knowledge/roadmap/recent-activity.md` для следующей сессии.

### Monthly deep audit (3–4 часа)

1. Все 30 промптов (RU + EN + ZH) × 3 прогона × 5 платформ + Google AI Overviews = 450+ точек.
2. Полный aggregate + trend vs предыдущий месяц.
3. Sentiment analysis (что говорят, не просто упоминают ли).
4. Source diversity — какие сайты ссылаются на JCK при цитировании.
5. Competitor map — кто из конкурентов растёт, кто падает.
6. Strategic recommendation: следующая волна работ, корректировка контент-pipeline, изменения off-site presence.

---

## 10. Boundary cases

### Case 1 — Vasily спрашивает «как мы видимы» в середине недели
Не нужно делать полный weekly. 1–2 ключевых промпта × ChatGPT + Yandex Neuro × 1 прогон = «текущий снимок». Vasily получает быстрый ответ, метрики не портятся.

### Case 2 — Post-Wave-A первый прогон (этой и следующих недель)
Первая неделя после деплоя ещё не репрезентативна — AI-модели нужно время на refresh. Ожидаемый импакт: 2–6 недель для Yandex Neuro, 4–12 недель для ChatGPT/Claude (зависит от частоты refresh их обучающих данных). Первый «настоящий» сравнительный baseline — на третью неделю.

### Case 3 — Платформа недоступна (Yandex Neuro в downtime, etc.)
Skip эту платформу на этой неделе, отметить в notes. Сохранить остальные. Не откладывать ритуал из-за одной платформы.

### Case 4 — Промпт начал давать резко другие ответы
Если конкретный промпт стабильно давал 1/3 mention и резко стал 0/3 на всех платформах одновременно — это сигнал крупного изменения (контент устарел, домен потерял позиции, у конкурента крупный move). Investigate отдельно.

---

## 11. Self-check questions

| Сомнение | Вопрос |
|---|---|
| Стоит ли запускать прогон сегодня | Прошло ли >7 дней с последнего? Vasily спросил? Был ли крупный change в продукте? Если хоть одно «да» — запускаем. |
| Достаточно ли 1 прогона вместо 3 | Никогда. 1 = noise. Минимум 2, лучше 3. Лучше меньше платформ × 3 прогона, чем больше платформ × 1 прогон. |
| Промпт даёт странный ответ — проблема ли это | Если 0/3 — паттерн. Если 1/3 — может быть случайность, повторить на следующей неделе. Если 0/3 на одной платформе и 2/3 на другой — платформо-специфика, нормально. |
| Стоит ли менять стартовый набор промптов | Через 1–2 месяца — да, по реальным customer questions. Раньше — нет, иначе ломаем сравнимость тренда. |
| Когда переключаться с manual на tool (Profound / Semrush) | Когда стало >2 часов на weekly прогон, или когда хотим автоматический tracking на 50+ промптов. ROI tool'а — экономия 6–10 часов в месяц. |

---

## 12. Connections to other skills

- **`geo-content-discipline`** — пара. Этот skill измеряет результат того, что делает geo-content. Если geo-content рекомендации соблюдаются, но citations не растут — значит проблема не в контенте, а в off-site (entity authority, brand mentions).
- **`research-protocol`** — если measurement показывает аномалию (резкое падение, странный паттерн), переходим в research-protocol для диагностики.
- **`bug-hunting`** — если causes аномалии техническая (краулеры не могут зайти, robots.txt сломан) — bug-hunting протокол.
- **`knowledge-structure`** — результаты ритуала пишутся в `jck-auto/knowledge/measurements/ai-visibility/YYYY-MM-DD.md`. Это новая подкатегория knowledge (можно вынести в `knowledge/measurements/` если будут другие measurement-семьи).

---

## 13. Reference

Полная фактура — `vibecoding-workspace/standards/ai-discovery-disciplines-standard.md`:
- §3 Метрики GEO/AEO (Citation Frequency, Mention Rate, Share of Voice, Sentiment, Prompt Win Rate)
- §4 Platform-specific механика (поведение каждой из 5 платформ)
- §2.5 LLM ответы не детерминированы (SparkToro/Gumshoe)
- §8 Authoritative sources (включая Profound 97.4% non-Tier-1, McKinsey China 2026)

При расхождении этого skill и Стандарта — Стандарт авторитетнее.

---

## 14. Changelog

- **2026-05-24 — v1.0.** Initial skill. Стартовый prompt set 30 промптов (RU + EN + ZH), 5-platform minimum prog, 3-run ensemble rule, measurement schema, weekly/monthly ритуал, trend analysis, 4 boundary cases.
