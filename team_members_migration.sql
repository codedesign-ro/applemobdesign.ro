-- ══════════════════════════════════════════════════════
-- AppleMob Design — team_members table
-- Run this in Supabase SQL Editor
-- ══════════════════════════════════════════════════════

create table if not exists public.team_members (
  id         uuid primary key default gen_random_uuid(),
  name       text not null,
  role_ro    text,
  role_en    text,
  phone      text,
  photo_url  text,
  order_num  integer default 1,
  is_active  boolean default true,
  created_at timestamptz default now()
);

-- RLS
alter table public.team_members enable row level security;

create policy "Public read active team members"
  on public.team_members for select
  using (is_active = true);

create policy "Authenticated full access team members"
  on public.team_members for all
  using (auth.role() = 'authenticated');

-- ── Seed data — cele 3 carduri ──
insert into public.team_members (name, role_ro, role_en, phone, photo_url, order_num, is_active) values
(
  'Daniel Marosan',
  'Director Executiv & Designer',
  'Executive Director & Designer',
  '0040 747 520 185',
  'https://applemobdesign.ro/wp-content/uploads/2020/10/team_member_img_2.jpg',
  1,
  true
),
(
  'Dan Buia',
  'Designer',
  'Designer',
  '0040 757 010 633',
  null,
  2,
  true
),
(
  'Andrei',
  'Designer',
  'Designer',
  '0040 753 778 366',
  null,
  3,
  true
);
