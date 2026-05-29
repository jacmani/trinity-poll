# Trinity World — Party Hall Sports Poll

A community polling app for **Trinity World Apartments, Kochi** — built for the Residents Association to understand which sports matches residents want screened at the Party Hall, and when.

---

## What this does

Residents open a link on their phones, vote for their sports preferences in under 60 seconds, and immediately see live community results. The Association uses the aggregate data to plan the Party Hall screening schedule for the season.

**Features:**
- 🌙 Dark / ☀️ Light mode toggle
- Live countdown to poll close (7 days)
- Real-time results — auto-refreshes every 8 seconds
- Scrolling live ticker showing top sports by interest
- Animated star field, shooting stars & floating particles
- Confetti on submission
- One vote per device (localStorage guard)
- Free-text comments & suggestions field
- Tower selection: Venus · Jupiter · Neptune · Mercury

---

## The poll covers

| Question | Type |
|----------|------|
| Your name | Optional text |
| Your tower | Optional single select |
| Which sports to screen? | Multi-select (8 options) |
| Best time to attend? | Single select |
| How often should we screen? | Multi-select |
| Comments & suggestions | Optional textarea |

**Sports options:** IPL 2026, Champions League, Women's T20 WC, FIFA World Cup, India International Cricket, Wimbledon, Formula 1, Commonwealth Games

---

## Tech stack

- **Frontend:** Single HTML file — no framework, no build step
- **Database:** [Supabase](https://supabase.com) (free tier, Postgres)
- **Hosting:** [Vercel](https://vercel.com) (free tier, auto-deploy from GitHub)
- **Fonts:** Cormorant Garamond + DM Sans via Google Fonts

---

## Project structure

```
trinity-poll/
├── index.html          ← The entire app (HTML + CSS + JS)
├── vercel.json         ← Vercel deployment config
├── supabase-setup.sql  ← Database table setup (run once)
├── CLAUDE.md           ← Context file for Claude Code AI
└── README.md           ← This file
```

---

## Getting started

### 1. Set up Supabase

1. Go to [supabase.com](https://supabase.com) → Create a new project (name: `trinity-world`)
2. Open **SQL Editor** → **New Query**
3. Paste the contents of `supabase-setup.sql` → click **Run**
4. Go to **Project Settings → API** and copy:
   - **Project URL** → e.g. `https://xxxxxxxxxxxx.supabase.co`
   - **anon public key** → long string starting with `eyJ...`

### 2. Add credentials to index.html

Open `index.html`, find these two lines near the bottom:

```js
const SUPABASE_URL  = 'YOUR_SUPABASE_URL';
const SUPABASE_ANON = 'YOUR_SUPABASE_ANON_KEY';
```

Replace both values with what you copied from Supabase.

### 3. Deploy to Vercel

Push to GitHub, then import the repo on [vercel.com](https://vercel.com):

```bash
git add .
git commit -m "Wire Supabase credentials"
git push
```

Vercel auto-deploys every time you push to `main`.

---

## Updating the poll

Any edit to `index.html` → commit → push → live in ~20 seconds.

```bash
git add .
git commit -m "What you changed"
git push
```

---

## Viewing responses

**Option 1 — Supabase Table Editor:**
Supabase Dashboard → Table Editor → `poll_votes`

**Option 2 — SQL query for comments:**
```sql
select name, tower, comments, created_at
from poll_votes
where comments is not null
order by created_at desc;
```

**Option 3 — Export to CSV:**
In Supabase Table Editor → click the download icon → Export as CSV

---

## Sharing with residents

**WhatsApp message template:**
> 🏆 Dear Trinity World Residents,
>
> We're planning sports screenings at the Party Hall this season!
> Take 60 seconds to tell us what you'd like to watch:
> 👉 [your-vercel-url]
>
> — Trinity World Residents Association

---

## About Trinity World

Trinity World Apartments is a residential complex in Thrikkakara, Kochi, Kerala with **841 units** across four towers — **Venus, Jupiter, Neptune and Mercury** — managed by the Trinity World Apartments Owners Association (TWAOA).

---

## Related projects

| Project | Description | Status |
|---------|-------------|--------|
| `style-guide` | Living HTML design system for Trinity World | ✅ Complete |
| `trinity-poll` | This app — Party Hall sports poll | 🚀 Active |
| `trinity-portal` | Full resident portal — announcements, amenities, events, gas meter uploads | 🔜 Upcoming |

---

*Built with Claude · Designed for Trinity World Kochi · 2026*
