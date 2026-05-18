import { cn } from '@/lib/utils'

interface CultureCardProps {
  children: React.ReactNode
  className?: string
  /** 그림자 단계 1~4 */
  shadow?: 1 | 2 | 3 | 4
  /** 클릭 가능한 카드 여부 */
  clickable?: boolean
  onClick?: () => void
}

const shadowMap = {
  1: 'shadow-1',
  2: 'shadow-2',
  3: 'shadow-3',
  4: 'shadow-4',
}

/**
 * Culture Link 카드 공통 컴포넌트.
 * - 토큰 기반 radius(rounded-lg = 16px), shadow, surface-raised 배경
 * - clickable=true 이면 hover 효과 + cursor-pointer
 */
export default function CultureCard({
  children,
  className,
  shadow = 1,
  clickable = false,
  onClick,
}: CultureCardProps) {
  return (
    <div
      onClick={onClick}
      className={cn(
        'rounded-lg bg-surface-raised p-4',
        shadowMap[shadow],
        clickable && 'cursor-pointer transition-shadow hover:shadow-2 active:scale-[.98]',
        className
      )}
    >
      {children}
    </div>
  )
}
