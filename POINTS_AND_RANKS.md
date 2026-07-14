# Points, ranks, and event stats

How the FAwizevent system actually works (from `server/src/ranking.ts` and admin APIs).

---

## What earns XP (your “points”)

**Only final placement at an event counts.** Wins, losses, draws, and “games played” do **not** add XP.

| Event finish (placement) | XP earned (that event) |
|--------------------------|------------------------|
| 1st | 100 |
| 2nd | 70 |
| 3rd | 50 |
| 4th | 30 |
| 5th | 30 |
| 6th | 25 |
| 7th | 25 |
| 8th | 20 |
| 9th or lower (up to 99) | 20 each (default) |
| No placement set | 0 |

**Event tier** (set when an admin creates the event) multiplies that event’s placement XP:

| Tier | Examples | Multiplier |
|------|----------|------------|
| Casual | Regular locals and open play | ×1.0 |
| Challenge | Glendower Thursday, Rosebank Wednesday, Monthly / Wizards Challenge | ×2.0 |
| Cup | Quarterly Cup, Wizards Cup (per store) | ×3.5 |

Example: 1st place (100 base) at a **Challenge** event → 200 XP.

**Total XP** = sum of XP from **every event** where that player has a placement recorded (after tier multiplier).

**Season XP** (leaderboards on Play) counts placement + judged-award XP from events dated in the current calendar year only.

**Home store** — chosen at sign-up (`Glendower` or `Rosebank`). Combined ladder ranks everyone by season XP; per-store tabs rank players at that store and highlight Challenge / Cup season leaders.

When an admin saves a placement, the server recalculates that player’s total XP and rank immediately.

**Judged awards (per event, max one winner each):**

| Award | Criteria | Bonus XP |
|-------|----------|----------|
| Best Bling Deck | Best-presented deck (full-arts, alt-arts, sleeves, etc.) | 50 × event tier |
| Best Rogue Deck | Most creative / original deck not following the meta | 50 × event tier |

Example: Challenge event (×2.0) → each award is **+100 XP**. Set in **Admin → Manage events → [event] → Awards**.

---

## Rank tiers (from total XP)

Rank is **not** chosen manually. It is the highest tier whose minimum XP you have reached.

| Rank | Minimum total XP |
|------|------------------|
| Bronze | 0 |
| Silver | 100 |
| Gold | 300 |
| Platinum | 650 |
| Diamond | 1200 |
| Champion | 2000 |

Example: three 1st-place finishes (100 + 100 + 100) → 300 XP → **Gold**.

---

## What admins do at an event

1. **Mark attended** — player was at the event (shows on leaderboard as an attendee).
2. **Set placement** — final standing (1–99). One number per player per event; **two players cannot share the same placement** at the same event.
3. **Optional: match tracking** — if the event has `use_match_tracking`, admins can log round-by-round results.

Placement can be set without match tracking. Match tracking is optional detail, not required for XP.

---

## Leaderboard columns (event page)

For players marked **attended**:

| Column | Meaning |
|--------|---------|
| **#** | Placement (admin-set). Lower number = better finish. |
| **GP** | Games played — count of recorded matches in that event. |
| **W / L / D** | Wins, losses, draws from those matches. |
| **Lost to** | Opponent from the player’s most recent loss in that event. |

These match stats are **display only**. They do **not** change XP or rank.

---

## Badges

**Automatic (from placement):**

- 1st → `placed1st`
- 2nd → `placed2nd`
- 3rd → `placed3rd`

**Manual (admin awards):** champion, flawless, magician, quick, scholar, scientist, sweat.

Manual badges are recognition only in the current code — **they do not add XP**. Only placement XP drives rank.

---

## Quick answers

- **“How many games do I need to play?”** — No minimum for XP. Play as many rounds as the event tracks; XP comes from **where you place**, not how many games you played.
- **“Do wins give points?”** — No. Wins show on the event leaderboard if matches are tracked; rank XP comes from **placement** only.
- **“What rank does 1st give?”** — 100 XP toward your **lifetime total**, which may move you from Bronze → Silver → Gold, etc., using the table above.

---

## Tuning values

Developers can change XP per place and rank thresholds in `server/src/ranking.ts` (`PLACEMENT_XP`, `RANK_MIN_XP`).
