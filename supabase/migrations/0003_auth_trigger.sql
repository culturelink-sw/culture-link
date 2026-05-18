-- ============================================================
-- Culture Link - Auth Trigger (standalone)
-- 0001_initial_schema.sql에 포함되어 있지만,
-- 트리거만 재설치할 때를 위한 독립 파일
--
-- 실행 방법: Supabase 대시보드 → SQL Editor → New query → 붙여넣기 → RUN
-- ============================================================

-- profiles.name을 nullable로 변경 (온보딩 전에는 이름이 없을 수 있음)
alter table public.profiles
  alter column name drop not null;

-- 트리거 함수: 신규 가입 시 profiles row 자동 생성
create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, name)
  values (
    new.id,
    -- 소셜 로그인이면 display_name, 이메일 로그인이면 @ 앞부분을 기본값으로
    coalesce(
      new.raw_user_meta_data->>'name',
      new.raw_user_meta_data->>'full_name',
      split_part(new.email, '@', 1)
    )
  )
  on conflict (id) do nothing; -- 중복 실행 안전
  return new;
end;
$$;

-- 기존 트리거 제거 후 재생성 (멱등성 보장)
drop trigger if exists on_auth_user_created on auth.users;

create trigger on_auth_user_created
  after insert on auth.users
  for each row
  execute procedure public.handle_new_user();
