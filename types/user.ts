export type Language = 'ko' | 'en' | 'es' | 'zh' | 'ja'

export interface UserProfile {
  id: string
  email: string
  nickname: string
  avatar_url?: string
  native_language: Language
  learning_languages: Language[]
  country?: string
  bio?: string
  created_at: string
  updated_at: string
}
