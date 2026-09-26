create table if not exists public.work_manager_states (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.work_manager_states enable row level security;

drop policy if exists "Users can read own work manager state" on public.work_manager_states;
create policy "Users can read own work manager state"
on public.work_manager_states
for select
to authenticated
using (auth.uid() = user_id);

drop policy if exists "Users can insert own work manager state" on public.work_manager_states;
create policy "Users can insert own work manager state"
on public.work_manager_states
for insert
to authenticated
with check (auth.uid() = user_id);

drop policy if exists "Users can update own work manager state" on public.work_manager_states;
create policy "Users can update own work manager state"
on public.work_manager_states
for update
to authenticated
using (auth.uid() = user_id)
with check (auth.uid() = user_id);

drop policy if exists "Users can delete own work manager state" on public.work_manager_states;
create policy "Users can delete own work manager state"
on public.work_manager_states
for delete
to authenticated
using (auth.uid() = user_id);
