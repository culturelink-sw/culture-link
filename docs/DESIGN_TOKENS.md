# Culture Link 디자인 토큰 사용 가이드

> 시각적 레퍼런스: [`docs/design-tokens.html`](./design-tokens.html) 를 브라우저로 열어보세요.

모든 토큰은 `app/globals.css` 의 `@theme` 블록에 등록되어 있어
Tailwind 유틸리티 클래스로 바로 사용할 수 있습니다.

---

## 🎨 색상 (Color)

### Coral — 브랜드 메인 컬러

| 클래스 | HEX | 용도 |
|---|---|---|
| `bg-coral-50` / `text-coral-50` | `#FFF1F2` | 아주 연한 배경 강조 |
| `bg-coral-100` | `#FFE0E3` | 태그 배경 |
| `bg-coral-400` | `#ED6E78` | 다크모드 Primary |
| **`bg-coral-500`** | **`#DC4757`** | **메인 버튼·링크·강조 (기본 선택)** |
| `bg-coral-600` | `#C12F40` | 버튼 hover 상태 |
| `bg-coral-700` | `#9C2333` | 강한 강조 텍스트 |

```tsx
// 버튼 예시
<button className="bg-coral-500 hover:bg-coral-600 text-white rounded-pill px-6 py-2">
  시작하기
</button>

// 링크 예시
<a className="text-coral-500 underline hover:text-coral-600">회원가입</a>
```

### Ink — 텍스트·배경 (따뜻한 그레이)

| 클래스 | HEX | 용도 |
|---|---|---|
| `bg-ink-50` | `#FBF7F6` | 페이지 배경 (= surface-canvas) |
| `bg-ink-100` | `#F4EEEC` | 섹션 구분 배경 |
| `border-ink-200` | `#E8DEDB` | 구분선·테두리 기본값 |
| `text-ink-400` | `#A89893` | placeholder |
| `text-ink-500` | `#7E6E69` | muted 텍스트 |
| `text-ink-600` | `#574A46` | 보조 텍스트 |
| **`text-ink-700`** | **`#3A302D`** | **본문 텍스트 (기본 선택)** |
| `text-ink-800` | `#251D1B` | 제목 텍스트 |

```tsx
// 본문 텍스트
<p className="text-ink-700">안녕하세요.</p>

// 보조 텍스트
<span className="text-ink-500 text-sm">2시간 전</span>
```

### Culture — 국가별 대표색

```tsx
// 국가 뱃지 예시
<span className="bg-culture-kr text-white rounded-pill px-2 py-0.5 text-xs">🇰🇷 한국</span>
<span className="bg-culture-en text-white rounded-pill px-2 py-0.5 text-xs">🇺🇸 English</span>
<span className="bg-culture-jp text-white rounded-pill px-2 py-0.5 text-xs">🇯🇵 日本語</span>
```

| 클래스 | 국가 |
|---|---|
| `bg-culture-kr` | 한국 `#DC4757` |
| `bg-culture-en` | 영어 `#3D6BE5` |
| `bg-culture-es` | 스페인어 `#F4A93A` |
| `bg-culture-cn` | 중국어 `#D43E2D` |
| `bg-culture-jp` | 일본어 `#B084DA` |

### Semantic

```tsx
<p className="text-success">저장되었습니다.</p>
<p className="text-danger">오류가 발생했습니다.</p>
<p className="text-warning">주의가 필요합니다.</p>
```

### Surface

```tsx
<div className="bg-surface-canvas">  {/* 전체 페이지 배경 */}
<div className="bg-surface-raised">  {/* 카드 배경 */}
<div className="bg-surface-pink">    {/* 강조 영역 */}
<div className="bg-surface-sunken"> {/* 인풋 등 눌린 느낌 */}
```

---

## ⬛ Border Radius

| 클래스 | 값 | 용도 |
|---|---|---|
| `rounded-xs` | 4px | 작은 뱃지, 태그 |
| `rounded-sm` | 8px | 인풋, 작은 카드 |
| `rounded-md` | 12px | 일반 카드 (기본) |
| `rounded-lg` | 16px | 큰 카드, 모달 |
| `rounded-xl` | 20px | 바텀 시트 |
| `rounded-2xl` | 28px | 최상위 컨테이너 |
| `rounded-pill` | 999px | 버튼, 뱃지 완전 타원 |

---

## 🌑 Shadow

```tsx
<div className="shadow-1">  {/* 미세한 구분 */}
<div className="shadow-2">  {/* 일반 카드 */}
<div className="shadow-3">  {/* 떠있는 UI */}
<div className="shadow-4">  {/* 모달, 드롭다운 */}
<div className="shadow-coral"> {/* coral 글로우 버튼 */}
```

---

## 🔤 Font

| 클래스 | 폰트 | 용도 |
|---|---|---|
| `font-kr` | Pretendard Variable | 한국어 UI 전반 (기본) |
| `font-en` | Inter | 영문 UI, 숫자 강조 |
| `font-mono` | JetBrains Mono | 코드, 고정폭 텍스트 |

```tsx
<h1 className="font-kr font-bold text-2xl">문화를 연결하다</h1>
<p className="font-en text-lg">Culture Link</p>
<code className="font-mono text-sm">npm run dev</code>
```

---

## 🧩 공통 컴포넌트

| 컴포넌트 | 경로 | 설명 |
|---|---|---|
| `<ScreenContainer>` | `components/common/ScreenContainer.tsx` | 페이지 최상위 래퍼 |
| `<TopHeader>` | `components/common/TopHeader.tsx` | 상단 헤더 |
| `<BottomNav>` | `components/common/BottomNav.tsx` | 하단 탭 네비게이션 |
| `<CultureCard>` | `components/common/CultureCard.tsx` | 카드 컴포넌트 |

```tsx
// 기본 페이지 레이아웃
import ScreenContainer from '@/components/common/ScreenContainer'
import TopHeader from '@/components/common/TopHeader'
import BottomNav from '@/components/common/BottomNav'
import CultureCard from '@/components/common/CultureCard'

export default function SomePage() {
  return (
    <>
      <TopHeader title="친구 찾기" />
      <ScreenContainer>
        <CultureCard shadow={2} clickable>
          <p className="text-ink-700 font-semibold">카드 내용</p>
        </CultureCard>
      </ScreenContainer>
      <BottomNav />
    </>
  )
}
```

---

## ⚡ 자주 쓰는 조합 치트시트

| 용도 | 클래스 조합 |
|---|---|
| 메인 버튼 | `bg-coral-500 hover:bg-coral-600 text-white rounded-pill shadow-coral` |
| 보조 버튼 | `bg-ink-100 hover:bg-ink-200 text-ink-700 rounded-pill` |
| 페이지 제목 | `text-ink-800 font-bold text-2xl font-kr` |
| 본문 텍스트 | `text-ink-700 text-base` |
| 보조 텍스트 | `text-ink-500 text-sm` |
| 구분선 | `border-ink-200` |
| 카드 배경 | `bg-surface-raised rounded-lg shadow-2` |
| 페이지 배경 | `bg-surface-canvas` |
| 에러 메시지 | `text-danger text-sm` |
| 성공 메시지 | `text-success text-sm` |
| 국가 뱃지(한국) | `bg-culture-kr text-white rounded-pill text-xs px-2 py-0.5` |
