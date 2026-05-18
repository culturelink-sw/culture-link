import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default function LandingPage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-8 p-4">
      {/* 일러스트 placeholder — 팀원이 디자인 시안대로 교체 예정 */}
      <div className="flex h-48 w-48 items-center justify-center rounded-full bg-surface-pink text-6xl">
        🌏
      </div>

      {/* 타이틀 */}
      <div className="space-y-2 text-center">
        <h1 className="text-4xl font-bold text-coral-500">
          Culture Link
        </h1>
        <p className="text-lg text-muted-foreground">
          다양한 문화를 연결하는 플랫폼
        </p>
      </div>

      {/* CTA 버튼 */}
      <div className="flex w-full max-w-xs flex-col gap-3">
        <Link href="/signup">
          <Button className="w-full bg-coral-500 hover:bg-coral-600">
            시작하기
          </Button>
        </Link>
        <Link href="/login">
          <Button variant="outline" className="w-full">
            로그인
          </Button>
        </Link>
      </div>
    </main>
  )
}
