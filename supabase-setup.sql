-- Im Supabase SQL Editor ausführen. Nur anonyme Einreichungen und aggregierte Auswertung.
create table if not exists public.quiz_results (
 id uuid primary key default gen_random_uuid(),
 quiz text not null check (quiz in ('bilder','webseiten')),
 answers jsonb not null check (jsonb_typeof(answers)='array' and jsonb_array_length(answers) between 1 and 6),
 created_at timestamptz not null default now()
);
alter table public.quiz_results enable row level security;
revoke all on public.quiz_results from anon, authenticated;
grant insert on public.quiz_results to anon;
drop policy if exists "anonymous insert" on public.quiz_results;
create policy "anonymous insert" on public.quiz_results for insert to anon with check (true);
create or replace function public.quiz_summary()
returns table (quiz text, question_id integer, responses bigint, incorrect bigint)
language sql security definer set search_path = ''
as $$
 select r.quiz, (a.item->>'question_id')::integer as question_id,
 count(*)::bigint as responses,
 count(*) filter (where (a.item->>'correct')::boolean = false)::bigint as incorrect
 from public.quiz_results r
 cross join lateral jsonb_array_elements(r.answers) as a(item)
 where a.item ? 'question_id' and a.item ? 'correct'
 group by r.quiz,(a.item->>'question_id')::integer
 order by r.quiz,question_id
$$;
revoke all on function public.quiz_summary() from public;
grant execute on function public.quiz_summary() to anon;
-- Für öffentliche Veranstaltungen: Supabase Rate-Limits / Abuse-Schutz aktivieren.
-- Bei offenem Dashboard sind nur aggregierte Werte sichtbar, keine Einzelantworten.
