-- ============================================================
-- Culture Link Initial Schema
-- ============================================================

-- UUID 확장
create extension if not exists "uuid-ossp";

-- ============================================================
-- 1. profiles
-- ============================================================
create table public.profiles (
  id                  uuid primary key references auth.users(id) on delete cascade,
  name                text not null,
  age                 integer,
  nationality         text,
  university          text,
  department          text,
  bio                 text,
  avatar_url          text,
  native_language     text not null default 'ko',
  learning_languages  text[] not null default '{}',
  created_at          timestamptz not null default now(),
  updated_at          timestamptz not null default now()
);

-- 신규 유저 가입 시 빈 프로필 자동 생성
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = public as $$
begin
  insert into public.profiles (id, name)
  values (
    new.id,
    coalesce(new.raw_user_meta_data->>'name', split_part(new.email, '@', 1))
  );
  return new;
end;
$$;

create trigger on_auth_user_created
  after insert on auth.users
  for each row execute procedure public.handle_new_user();

-- updated_at 자동 갱신
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

create trigger profiles_updated_at
  before update on public.profiles
  for each row execute procedure public.set_updated_at();

-- ============================================================
-- 2. interests (관심사 태그 마스터)
-- ============================================================
create table public.interests (
  id       uuid primary key default uuid_generate_v4(),
  name     text not null unique,
  category text
);

-- ============================================================
-- 3. user_interests (프로필 ↔ 관심사 다대다)
-- ============================================================
create table public.user_interests (
  user_id     uuid not null references public.profiles(id) on delete cascade,
  interest_id uuid not null references public.interests(id) on delete cascade,
  primary key (user_id, interest_id)
);

-- ============================================================
-- 4. matches
-- ============================================================
create table public.matches (
  id            uuid primary key default uuid_generate_v4(),
  requester_id  uuid not null references public.profiles(id) on delete cascade,
  receiver_id   uuid not null references public.profiles(id) on delete cascade,
  status        text not null default 'pending'
                  check (status in ('pending', 'accepted', 'rejected')),
  created_at    timestamptz not null default now(),
  updated_at    timestamptz not null default now(),
  -- 같은 쌍으로 중복 요청 방지
  unique (requester_id, receiver_id)
);

create trigger matches_updated_at
  before update on public.matches
  for each row execute procedure public.set_updated_at();

-- ============================================================
-- 5. chat_rooms (수락된 매칭당 1개)
-- ============================================================
create table public.chat_rooms (
  id         uuid primary key default uuid_generate_v4(),
  match_id   uuid not null unique references public.matches(id) on delete cascade,
  created_at timestamptz not null default now()
);

-- ============================================================
-- 6. messages
-- ============================================================
create table public.messages (
  id                  uuid primary key default uuid_generate_v4(),
  room_id             uuid not null references public.chat_rooms(id) on delete cascade,
  sender_id           uuid not null references public.profiles(id) on delete cascade,
  original_content    text not null,
  original_language   text not null,
  translated_content  jsonb not null default '{}',
  created_at          timestamptz not null default now()
);

-- 최신 메시지 조회 성능
create index messages_room_created_idx on public.messages(room_id, created_at desc);

-- ============================================================
-- 7. posts (문화 피드)
-- ============================================================
create table public.posts (
  id         uuid primary key default uuid_generate_v4(),
  user_id    uuid not null references public.profiles(id) on delete cascade,
  content    text not null,
  images     text[] not null default '{}',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create trigger posts_updated_at
  before update on public.posts
  for each row execute procedure public.set_updated_at();

-- ============================================================
-- 8. post_likes
-- ============================================================
create table public.post_likes (
  post_id    uuid not null references public.posts(id) on delete cascade,
  user_id    uuid not null references public.profiles(id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (post_id, user_id)
);

-- ============================================================
-- 9. comments
-- ============================================================
create table public.comments (
  id         uuid primary key default uuid_generate_v4(),
  post_id    uuid not null references public.posts(id) on delete cascade,
  user_id    uuid not null references public.profiles(id) on delete cascade,
  content    text not null,
  created_at timestamptz not null default now()
);

-- ============================================================
-- 10. events (목업)
-- ============================================================
create table public.events (
  id          uuid primary key default uuid_generate_v4(),
  title       text not null,
  description text,
  event_date  timestamptz,
  location    text,
  image_url   text,
  created_by  uuid references public.profiles(id) on delete set null,
  created_at  timestamptz not null default now()
);

-- ============================================================
-- 11. encyclopedia_entries (목업)
-- ============================================================
create table public.encyclopedia_entries (
  id         uuid primary key default uuid_generate_v4(),
  category   text,
  country    text,
  title      jsonb not null default '{}',
  content    jsonb not null default '{}',
  created_at timestamptz not null default now()
);

-- ============================================================
-- RLS 활성화
-- ============================================================
alter table public.profiles            enable row level security;
alter table public.interests           enable row level security;
alter table public.user_interests      enable row level security;
alter table public.matches             enable row level security;
alter table public.chat_rooms          enable row level security;
alter table public.messages            enable row level security;
alter table public.posts               enable row level security;
alter table public.post_likes          enable row level security;
alter table public.comments            enable row level security;
alter table public.events              enable row level security;
alter table public.encyclopedia_entries enable row level security;

-- ============================================================
-- RLS 정책
-- ============================================================

-- profiles
create policy "프로필 전체 공개 읽기"
  on public.profiles for select using (true);

create policy "본인 프로필만 수정"
  on public.profiles for update using (auth.uid() = id);

-- interests (읽기 전용 공개)
create policy "관심사 태그 전체 공개"
  on public.interests for select using (true);

-- user_interests
create policy "관심사 전체 공개 읽기"
  on public.user_interests for select using (true);

create policy "본인 관심사만 추가"
  on public.user_interests for insert with check (auth.uid() = user_id);

create policy "본인 관심사만 삭제"
  on public.user_interests for delete using (auth.uid() = user_id);

-- matches
create policy "본인 매칭만 읽기"
  on public.matches for select
  using (auth.uid() = requester_id or auth.uid() = receiver_id);

create policy "매칭 요청 생성"
  on public.matches for insert with check (auth.uid() = requester_id);

create policy "수신자만 상태 변경"
  on public.matches for update using (auth.uid() = receiver_id);

-- chat_rooms
create policy "채팅방 당사자만 읽기"
  on public.chat_rooms for select
  using (
    exists (
      select 1 from public.matches m
      where m.id = match_id
        and (m.requester_id = auth.uid() or m.receiver_id = auth.uid())
    )
  );

-- messages
create policy "채팅방 당사자만 메시지 읽기"
  on public.messages for select
  using (
    exists (
      select 1 from public.chat_rooms cr
      join public.matches m on m.id = cr.match_id
      where cr.id = room_id
        and (m.requester_id = auth.uid() or m.receiver_id = auth.uid())
    )
  );

create policy "채팅방 당사자만 메시지 전송"
  on public.messages for insert
  with check (
    auth.uid() = sender_id
    and exists (
      select 1 from public.chat_rooms cr
      join public.matches m on m.id = cr.match_id
      where cr.id = room_id
        and (m.requester_id = auth.uid() or m.receiver_id = auth.uid())
    )
  );

-- posts
create policy "게시글 전체 공개 읽기"
  on public.posts for select using (true);

create policy "본인만 게시글 작성"
  on public.posts for insert with check (auth.uid() = user_id);

create policy "본인만 게시글 수정"
  on public.posts for update using (auth.uid() = user_id);

create policy "본인만 게시글 삭제"
  on public.posts for delete using (auth.uid() = user_id);

-- post_likes
create policy "좋아요 전체 공개 읽기"
  on public.post_likes for select using (true);

create policy "본인만 좋아요 추가"
  on public.post_likes for insert with check (auth.uid() = user_id);

create policy "본인만 좋아요 삭제"
  on public.post_likes for delete using (auth.uid() = user_id);

-- comments
create policy "댓글 전체 공개 읽기"
  on public.comments for select using (true);

create policy "본인만 댓글 작성"
  on public.comments for insert with check (auth.uid() = user_id);

create policy "본인만 댓글 삭제"
  on public.comments for delete using (auth.uid() = user_id);

-- events
create policy "이벤트 전체 공개 읽기"
  on public.events for select using (true);

create policy "로그인 유저만 이벤트 생성"
  on public.events for insert with check (auth.uid() = created_by);

-- encyclopedia_entries (읽기 전용)
create policy "백과사전 전체 공개 읽기"
  on public.encyclopedia_entries for select using (true);

-- ============================================================
-- 초기 더미 데이터 (관심사 태그)
-- ============================================================
insert into public.interests (name, category) values
  ('여행', '취미'), ('음악', '취미'), ('요리', '취미'), ('독서', '취미'),
  ('영화', '취미'), ('게임', '취미'), ('사진', '취미'), ('등산', '스포츠'),
  ('축구', '스포츠'), ('농구', '스포츠'), ('수영', '스포츠'), ('요가', '스포츠'),
  ('K-POP', '문화'), ('K-드라마', '문화'), ('애니메이션', '문화'), ('만화', '문화'),
  ('언어교환', '학습'), ('프로그래밍', '학습'), ('디자인', '학습'), ('경제', '학습');
