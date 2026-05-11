export type Language = 'ko' | 'en' | 'es' | 'zh' | 'ja'
export type MatchStatus = 'pending' | 'accepted' | 'rejected'

// ============================================================
// 테이블 Row 타입 (DB에서 읽어올 때)
// ============================================================

export interface Profile {
  id: string
  name: string
  age: number | null
  nationality: string | null
  university: string | null
  department: string | null
  bio: string | null
  avatar_url: string | null
  native_language: string
  learning_languages: string[]
  created_at: string
  updated_at: string
}

export interface Interest {
  id: string
  name: string
  category: string | null
}

export interface UserInterest {
  user_id: string
  interest_id: string
}

export interface Match {
  id: string
  requester_id: string
  receiver_id: string
  status: MatchStatus
  created_at: string
  updated_at: string
}

export interface ChatRoom {
  id: string
  match_id: string
  created_at: string
}

export interface Message {
  id: string
  room_id: string
  sender_id: string
  original_content: string
  original_language: string
  translated_content: Record<string, string>
  created_at: string
}

export interface Post {
  id: string
  user_id: string
  content: string
  images: string[]
  created_at: string
  updated_at: string
}

export interface PostLike {
  post_id: string
  user_id: string
  created_at: string
}

export interface Comment {
  id: string
  post_id: string
  user_id: string
  content: string
  created_at: string
}

export interface Event {
  id: string
  title: string
  description: string | null
  event_date: string | null
  location: string | null
  image_url: string | null
  created_by: string | null
  created_at: string
}

export interface EncyclopediaEntry {
  id: string
  category: string | null
  country: string | null
  title: Record<string, string>
  content: Record<string, string>
  created_at: string
}

// ============================================================
// Insert 타입 (DB에 삽입할 때 - id/created_at 제외)
// ============================================================

export type ProfileInsert = Omit<Profile, 'created_at' | 'updated_at'>
export type PostInsert = Omit<Post, 'id' | 'created_at' | 'updated_at'>
export type MessageInsert = Omit<Message, 'id' | 'created_at'>
export type CommentInsert = Omit<Comment, 'id' | 'created_at'>
export type MatchInsert = Omit<Match, 'id' | 'created_at' | 'updated_at'>
export type EventInsert = Omit<Event, 'id' | 'created_at'>

// ============================================================
// Update 타입 (부분 수정용)
// ============================================================

export type ProfileUpdate = Partial<Omit<Profile, 'id' | 'created_at' | 'updated_at'>>
export type PostUpdate = Partial<Pick<Post, 'content' | 'images'>>

// ============================================================
// 조인 타입 (자주 쓰는 조합)
// ============================================================

// 프로필 + 관심사 태그 목록
export interface ProfileWithInterests extends Profile {
  interests: Interest[]
}

// 게시글 + 작성자 + 좋아요 수
export interface PostWithMeta extends Post {
  author: Pick<Profile, 'id' | 'name' | 'avatar_url'>
  likes_count: number
  comments_count: number
  is_liked?: boolean
}

// 매칭 + 상대방 프로필
export interface MatchWithProfile extends Match {
  partner: ProfileWithInterests
}

// 메시지 + 발신자 프로필
export interface MessageWithSender extends Message {
  sender: Pick<Profile, 'id' | 'name' | 'avatar_url'>
}
