-- ============================================================
-- Culture Link - Performance Indexes
-- ============================================================

-- ----------------------------------------------------------------
-- user_interests
-- ----------------------------------------------------------------

-- 특정 유저의 관심사 목록 조회 (매칭 알고리즘 진입점)
create index if not exists idx_user_interests_user_id
  on public.user_interests(user_id);

-- 특정 관심사를 가진 유저 목록 조회 (공통 관심사 많은 순 매칭)
create index if not exists idx_user_interests_interest_id
  on public.user_interests(interest_id);

-- ----------------------------------------------------------------
-- messages
-- ----------------------------------------------------------------

-- 채팅방의 메시지 목록 조회
create index if not exists idx_messages_room_id
  on public.messages(room_id);

-- 채팅방 메시지 최신순 정렬 (room_id + created_at 복합 인덱스는 0001에서 생성됨)
create index if not exists idx_messages_created_at
  on public.messages(created_at desc);

-- ----------------------------------------------------------------
-- matches
-- ----------------------------------------------------------------

-- 내가 보낸 매칭 요청 목록 조회
create index if not exists idx_matches_requester_id
  on public.matches(requester_id);

-- 내가 받은 매칭 요청 목록 조회
create index if not exists idx_matches_receiver_id
  on public.matches(receiver_id);

-- 상태별 필터링 (pending 목록, accepted 목록 등)
create index if not exists idx_matches_status
  on public.matches(status);

-- ----------------------------------------------------------------
-- posts
-- ----------------------------------------------------------------

-- 특정 유저의 게시글 목록 조회
create index if not exists idx_posts_user_id
  on public.posts(user_id);

-- 피드 최신순 정렬
create index if not exists idx_posts_created_at
  on public.posts(created_at desc);

-- ----------------------------------------------------------------
-- post_likes
-- ----------------------------------------------------------------

-- 게시글별 좋아요 수 카운트
create index if not exists idx_post_likes_post_id
  on public.post_likes(post_id);

-- ----------------------------------------------------------------
-- comments
-- ----------------------------------------------------------------

-- 게시글별 댓글 목록 조회 및 카운트
create index if not exists idx_comments_post_id
  on public.comments(post_id);

-- ----------------------------------------------------------------
-- chat_rooms
-- ----------------------------------------------------------------

-- match_id → chat_room 조회 (UNIQUE 제약으로 자동 생성되지만 명시적 선언)
create index if not exists idx_chat_rooms_match_id
  on public.chat_rooms(match_id);
