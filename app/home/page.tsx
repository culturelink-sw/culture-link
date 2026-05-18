import { redirect } from 'next/navigation'
import { createClient } from '@/lib/supabase/server'
import { Button } from '@/components/ui/button'

export default async function HomePage() {
  const supabase = await createClient()
  const { data: { user } } = await supabase.auth.getUser()

  if (!user) redirect('/login')

  async function handleSignOut() {
    'use server'
    const supabase = await createClient()
    await supabase.auth.signOut()
    redirect('/')
  }

  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-6 p-4">
      <h1 className="text-2xl font-bold text-center">
        Culture Link에 오신 것을 환영합니다 👋
      </h1>
      <p className="text-muted-foreground">{user.email}</p>
      <form action={handleSignOut}>
        <Button type="submit" variant="outline">
          로그아웃
        </Button>
      </form>
    </main>
  )
}
