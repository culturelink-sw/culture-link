import Link from 'next/link'
import { cn } from '@/lib/utils'

interface TopHeaderProps {
  /** 가운데 제목 */
  title?: string
  /** 왼쪽 영역 (뒤로가기 버튼 등) */
  left?: React.ReactNode
  /** 오른쪽 영역 (아이콘 버튼 등) */
  right?: React.ReactNode
  className?: string
}

/**
 * 상단 헤더 공통 컴포넌트.
 * - title 없으면 Culture Link 로고 텍스트 표시
 * - left / right 슬롯으로 버튼 삽입 가능
 */
export default function TopHeader({ title, left, right, className }: TopHeaderProps) {
  return (
    <header
      className={cn(
        'sticky top-0 z-50 flex h-14 items-center justify-between',
        'border-b border-ink-200 bg-surface-raised px-4 shadow-1',
        className
      )}
    >
      {/* 왼쪽 슬롯 */}
      <div className="w-10">{left}</div>

      {/* 중앙 타이틀 */}
      <div className="flex-1 text-center">
        {title ? (
          <span className="text-base font-semibold text-ink-800">{title}</span>
        ) : (
          <Link href="/home" className="text-lg font-bold text-coral-500">
            Culture Link
          </Link>
        )}
      </div>

      {/* 오른쪽 슬롯 */}
      <div className="w-10 flex justify-end">{right}</div>
    </header>
  )
}
