# CLAUDE.md — Trinity World Sports Poll
> Machine-readable context for Claude Code. Read this before touching any file.

---

## What this project is
A resident polling app for **Trinity World Apartments**, Kochi, Kerala.
Built for the **Trinity World Apartments Owners Association (TWAOA)** to gauge resident interest in sports screenings at the Party Hall.

**Live URL:** https://trinity-poll.vercel.app
**GitHub:** https://github.com/jacmani/trinity-poll
**Deployed via:** Vercel (auto-deploys on every push to `main`)

---

## The community context
- **841 residential units** across 4 towers: Venus, Jupiter, Neptune, Mercury
- Mixed demographic: families, singles, elderly — heads of household
- Primary communication channels: WhatsApp groups, MyGate app
- Association email: association@trinityworldkochi.com
- Located in Thrikkakara, Kochi, Kerala

---

## Tech stack
| Layer | Choice | Why |
|-------|--------|-----|
| Frontend | Single-file HTML/CSS/JS | No build step, instant deploy, easy to edit |
| Database | Supabase REST API | Free tier, real-time capable, Postgres |
| Hosting | Vercel static | Auto-deploy from GitHub, free tier |
| Fonts | Cormorant Garamond + DM Sans | Google Fonts, matches TW style guide |

**No framework. No bundler. No node_modules. Just one HTML file.**

---

## File structure
```
trinity-poll/
├── index.html          ← Entire app lives here
├── vercel.json         ← Vercel routing config (do not modify)
├── supabase-setup.sql  ← Run once in Supabase SQL Editor to create table
├── CLAUDE.md           ← This file
└── README.md           ← Human-readable documentation
```

---

## Key config — inside index.html (bottom <script> block)
```js
const SUPABASE_URL  = 'YOUR_SUPABASE_URL';   // Supabase → Project Settings → API → Project URL
const SUPABASE_ANON = 'YOUR_SUPABASE_ANON_KEY'; // Supabase → Project Settings → API → anon public
const TOTAL_UNITS   = 841;                    // Total residential units
const POLL_EXPIRY   = 7 days from first load; // Stored in localStorage per device
```

---

## Supabase schema — table: poll_votes
```sql
id          uuid        primary key (auto)
name        text        optional — resident's name
tower       text        optional — Venus / Jupiter / Neptune / Mercury
sports      text[]      multi-select array
timing      text        single select — evening / latenight / both / weekend
freq        text[]      multi-select array — every / india / knockouts / weekend
comments    text        optional free-text suggestions
created_at  timestamptz auto — UTC timestamp
```

---

## Design system
This project uses the **Trinity World living style guide** (see `../style-guide/`).

### Colour tokens (CSS custom properties)
| Token | Dark mode | Light mode |
|-------|-----------|------------|
| `--bg` | `#080B14` | `#F5F0E8` |
| `--gold` | `#C9922A` | `#A8740E` |
| `--gold-bright` | `#E8B84A` | `#C9922A` |
| `--rust` | `#B84E2C` | `#963C1E` |
| `--text-primary` | `#F0EDE8` | `#1A1208` |

### Animation system
- **3 ambient orbs** — drifting radial gradients, 22–35s loops, pure CSS
- **Star field** — 90 static + 30 twinkling stars, canvas-drawn, dark mode only
- **Shooting stars** — pool of 4 DOM elements, fires every 7–15s, dark mode only
- **Rangoli dots** — warm golden hex grid, canvas-drawn, light mode only
- **28 ember particles** — sine-wave float, pure CSS keyframes
- **Orbit ring + dot** — on TW monogram, 12s rotation

### Glass card system
```css
background: rgba(255,255,255,0.05)
backdrop-filter: blur(24px) saturate(180%)
border: 1px solid rgba(255,255,255,0.10)
box-shadow: 0 8px 32px rgba(0,0,0,0.4), inset 0 1px 0 rgba(255,255,255,0.07)
```

---

## Dual mode (dark / light)
- Toggle: fixed 🌙/☀️ pill, top-right, z-index 1000
- Controlled via `data-theme` attribute on `<html>`
- Preference saved to `localStorage` key: `tw_mode_v1`
- All tokens defined in `:root` (dark) and `[data-theme="light"]`

---

## Vote flow
1. Resident opens link on mobile
2. Fills form: name (opt), tower (opt), sports (multi), timing (single), freq (multi), comments (opt)
3. Submits → inserts row to Supabase `poll_votes`
4. Confetti fires, form transitions to results screen
5. Results auto-refresh every 8 seconds via `setInterval`
6. `localStorage` key `tw_poll_v3` prevents double-voting per device

### Fallback
If Supabase credentials are not set or the request fails, votes aggregate locally in `localStorage` key `tw_local_agg_v3`. Results still display — just not cross-device.

---

## Deploy workflow
```bash
# Any change to index.html:
git add .
git commit -m "describe what changed"
git push
# Vercel detects push → auto-redeploys in ~20 seconds
```

---

## Related projects (sibling folders)
```
../style-guide/     Trinity World living HTML style guide
../trinity-portal/  Main resident portal — UPCOMING
../assets/          Shared logos, images, brand files
```

---

## What NOT to do
- Do not add a build system, package.json, or node_modules
- Do not split into multiple files (keep it single-file)
- Do not change `vercel.json` routing config
- Do not hardcode Supabase credentials — keep as named constants at top of script
- Do not modify the Supabase schema without updating this file
