import Link from 'next/link'
import { Button } from '@/components/ui/button'

export default function OnboardingPage() {
  return (
    <main className="flex min-h-screen flex-col items-center justify-center gap-6 p-4">
      <h1 className="text-2xl font-bold">프로필을 설정해주세요</h1>
      <p className="text-muted-foreground text-center">
        이름, 국적, 관심사 등을 입력하면 더 잘 맞는 친구를 찾을 수 있어요.
      </p>

      {/* TODO: 팀원이 프로필 입력 폼 추가 예정 */}
      <div className="w-full max-w-md rounded-lg border border-dashed border-gray-300 p-12 text-center text-sm text-muted-foreground">
        프로필 입력 폼 (추후 구현)
      </div>

      <Link href="/home">
        <Button variant="ghost">지금 건너뛰기 →</Button>
      </Link>
    </main>
  )
}
