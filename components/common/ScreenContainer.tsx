import { cn } from '@/lib/utils'

interface ScreenContainerProps {
  children: React.ReactNode
  className?: string
  /** 하단 탭바 공간 확보 여부 (기본 true) */
  withBottomNav?: boolean
}

/**
 * 모든 페이지의 최상위 래퍼.
 * - 최대 너비, 좌우 패딩, 캔버스 배경 통일
 * - withBottomNav=true 이면 하단에 pb-20 추가 (BottomNav 높이 보정)
 */
export default function ScreenContainer({
  children,
  className,
  withBottomNav = true,
}: ScreenContainerProps) {
  return (
    <div
      className={cn(
        'mx-auto w-full max-w-md flex-1 bg-surface-canvas',
        withBottomNav && 'pb-20',
        className
      )}
    >
      {children}
    </div>
  )
}
