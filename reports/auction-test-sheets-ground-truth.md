# Auction test sheets — GROUND TRUTH (verified from the actual sheet image)

> Purpose: an objective reference of what is ACTUALLY printed on each recurring test sheet,
> so decode logs can be compared against fact, not against a guess. Claude must NOT state a
> field value for a sheet unless it is recorded here as verified-from-image, or visible in the
> log's own image. "Unknown" means: not yet confirmed from the image — do NOT guess it.
>
> Rule: if a log shows a value that contradicts a verified value here, the LOG is wrong
> (mis-read / fabrication), not this file. If this file says "unknown", say "need to check the
> image", never invent a value.

---

## WISH (printed) — VERIFIED 2026-06-30 from the sheet image in decode log 09:33

Verified directly by viewing the sheet image (top row + diagram legible):

| Field | Actual value on sheet |
|---|---|
| 出品番号 (lot) | 218 |
| 初度登録 (first reg) | H27 (2015), 2月 |
| 車名 (model) | ウィッシュ (Wish) |
| ドア形状 (door/body) | 5W |
| グレード (grade trim) | 1.8X 4WD |
| 評価点 (overall grade) | **3.5** |
| 外装 (exterior grade) | **D** |
| 内装 (interior grade) | **C** |
| 走行 (mileage) | 199,559 km |
| 車検 (shaken) | 04年02月 |
| 登録番号 (reg plate) | 札幌 (Sapporo) 533 ... 300 |
| 排気量 (displacement) | 1800 cc |
| 燃料 (fuel) | ガソリン (petrol) |
| 型式 (model code) | DBA-ZGE25G |
| シフト (shift) | IAT |
| エアコン | AAC |
| 外装色 (colour) | シルバー (silver) |
| カラーNo. (colour code) | 1F7 |
| 内装色 (interior colour) | クロ系 (black-ish) |
| 乗車定員 (seats) | 7 |
| リサイクル預託金 (recycle fee) | 10,460 円 |
| 車台番号 (VIN/chassis) | ZGE25-6006238 |
| 諸元 (dimensions) | 459 / 169 / 160 (cm) |
| 会場 (venue) | (not clearly captured — check image) |

### WISH diagram — REAL damage marks (counted from the image, ~15):
X3 (hood/top), A2 (centre/bonnet), A1 (right front fender), G (centre = windshield chip per legend),
A1 + B1 (left side), A1 (left lower), A1 (right rear), U1 (left rear lower), U4 (rear), B1 (lower),
B2 + X2 (rear bumper). Plus `0` `0` near wheels.
- Legend on sheet bottom: A=キズ(scratch) U=へこみ(dent) B=キズを伴うへこみ(dent+scratch) P=要塗装 W=補修跡 S=サビ C=腐食 G=フロントガラス点キズ(windshield chip) XX=交換済み X=要交換. Exterior/interior grade scale A·B·C·D·E.
- Wheels: four `[3]` (tread, tenths) + `[T]` bottom. → tireTread ~ 3/10 several wheels.
- Inspector text column (検査員記入欄, SEPARATE from diagram → expertComments, NOT bodyDamages):
  下廻りS大 / エンジンルームS / 下廻りAU / ハンドルグリップ不良 / シートすれ中 /
  スタッドレスタイヤ / 社外アルミホイール / ホイールC.
- `G` belongs to the windshield (centre), NOT a door — a log placing G on a door is a zone error.

---

## ALLION (handwritten, HAA / 京都, lot 15593) — PARTIAL

Verified facts (consistent across multiple logs / earlier session ground-truth):

| Field | Value | Source |
|---|---|---|
| 車名 (model) | アリオン (Allion) | OCR consistent |
| make | Toyota (トヨタ) | known |
| lot | 15593 | OCR consistent |
| 型式 (model code) | DBA-ZRT260 | known (logs sometimes mis-read as D8A-ZRT60) |
| 排気量 | 1800 cc | OCR consistent |
| 初度登録 / year | 2016 (H28), 4月 | OCR consistent |
| 走行 (mileage) | 100 km | OCR consistent |
| 外観色 (colour) | パールレッド (pearl red) | OCR consistent |
| auction house | HAA | sheet (v1: HAA 物産 オーダーソフト出品票) |
| 登録地 (reg region) | 京都 (Kyoto) | sheet |

**overallGrade / interiorGrade: UNKNOWN — NOT YET CONFIRMED FROM IMAGE.**
- Per Vasily (2026-06-30): the Allion sheet does NOT have grade "A" and does NOT have grade "2".
- Logs that emitted overallGrade "A" (e.g. 11:12) or "2" (earlier) are MIS-READS, not the real value.
- The letters A / A / S seen in strip h2 OCR are exterior/area assessment marks bleeding from a text
  column, NOT the overall 評価点. Do NOT bind them to overallGrade.
- ACTION: when an Allion sheet image is in a log, view it and fill the real 評価点 here. Until then,
  treat any Allion overallGrade in a log as unverified.

### ALLION diagram:
- Essentially clean — no real damage codes, no tread digits. bodyDamages SHOULD be [] and tireTread null.
- A log emitting any bodyDamages entry for Allion (e.g. a lone "A1") is a false mark (text letters
  leaking into the diagram zone), not a real diagram mark.

---

## HONDA FREED (printed) — from logs (to be image-verified)
FREED G HONDA SENSING, DBA-GB5, 1500cc, grade 4.0 / ext C / int B, mileage ~101000, 名古屋会場 (Nagoya),
ownership 自家用 (private). colorCode NH830M.

## TOYOTA HARRIER (printed) — from logs (to be image-verified)
Grade 6 / int 5, 中部デビュー auction, lot 33099, year 2023.

---

## How to use this file
1. Before claiming any test-sheet field value from a log, check it here.
2. If verified here and the log differs → log is wrong; say so.
3. If "unknown" here → view the log's image to confirm; never guess.
4. When you view a sheet image and learn a real value, ADD it here (verified-from-image) so the
   reference grows and future log comparisons stay objective.
