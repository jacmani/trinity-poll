-- ═══════════════════════════════════════════════════════
-- Trinity World Sports Poll — Supabase Setup (v4)
-- Run in: Supabase Dashboard → SQL Editor → New Query
-- ═══════════════════════════════════════════════════════

create table if not exists poll_votes (
  id          uuid default gen_random_uuid() primary key,
  name        text,
  tower       text,
  sports      text[],       -- multi-select array
  timing      text,
  freq        text[],       -- multi-select array (updated from text)
  comments    text,         -- free-text suggestions field
  created_at  timestamptz default now()
);

alter table poll_votes enable row level security;

create policy "Anyone can vote"
  on poll_votes for insert with check (true);

create policy "Anyone can read results"
  on poll_votes for select using (true);

-- ═══════════════════════════════════════════════════════
-- If you already ran a previous version of this table,
-- run these ALTER statements instead:
--
-- alter table poll_votes alter column freq type text[] using array[freq];
-- alter table poll_votes add column if not exists comments text;
-- ═══════════════════════════════════════════════════════

-- ═══════════════════════════════════════════════════════
-- After running, go to:
-- Supabase → Project Settings → API
--   Project URL  →  SUPABASE_URL  in index.html  (line ~620)
--   anon key     →  SUPABASE_ANON in index.html  (line ~621)
-- ═══════════════════════════════════════════════════════
