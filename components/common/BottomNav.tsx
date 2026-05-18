'use client'

import Link from 'next/link'
import { usePathname } from 'next/navigation'
import { cn } from '@/lib/utils'

const NAV_ITEMS = [
  { href: '/home',    label: '홈',     icon: '🏠' },
  { href: '/matches', label: '매칭',   icon: '💞' },
  { href: '/feed',    label: '피드',   icon: '🌍' },
  { href: '/chat',    label: '채팅',   icon: '💬' },
  { href: '/profile', label: '프로필', icon: '👤' },
]

/**
 * 하단 탭 네비게이션.
 * - 현재 경로와 일치하는 탭에 coral-500 활성화 스타일
 * - ScreenContainer(withBottomNav=true) 와 함께 사용
 */
export default function BottomNav() {
  const pathname = usePathname()

  return (
    <nav className="fixed bottom-0 left-0 right-0 z-50 mx-auto max-w-md border-t border-ink-200 bg-surface-raised shadow-3">
      <ul className="flex h-16 items-center">
        {NAV_ITEMS.map(({ href, label, icon }) => {
          const active = pathname.startsWith(href)
          return (
            <li key={href} className="flex-1">
              <Link
                href={href}
                className={cn(
                  'flex flex-col items-center gap-0.5 py-2 text-xs transition-colors',
                  active
                    ? 'text-coral-500 font-semibold'
                    : 'text-ink-400 hover:text-ink-600'
                )}
              >
                <span className="text-xl leading-none">{icon}</span>
                <span>{label}</span>
              </Link>
            </li>
          )
        })}
      </ul>
    </nav>
  )
}
