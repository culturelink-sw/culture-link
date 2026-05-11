export type MatchStatus = 'pending' | 'accepted' | 'rejected'

export interface Match {
  id: string
  user_a_id: string
  user_b_id: string
  status: MatchStatus
  created_at: string
  updated_at: string
}
