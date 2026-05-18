-- ============================================================
-- Culture Link - Seed Data
-- 시연/개발용 더미 데이터 (재실행 안전: ON CONFLICT DO NOTHING)
-- ============================================================

-- ----------------------------------------------------------------
-- 1. interests (관심사 태그 20개)
-- ----------------------------------------------------------------
insert into public.interests (name, category) values
  -- 문화
  ('K-POP',     '문화'),
  ('영화',       '문화'),
  ('드라마',     '문화'),
  ('애니메이션', '문화'),
  ('음악',       '문화'),
  -- 취미
  ('사진',       '취미'),
  ('게임',       '취미'),
  ('책',         '취미'),
  ('요리',       '취미'),
  ('카페',       '취미'),
  -- 스포츠
  ('등산',       '스포츠'),
  ('자전거',     '스포츠'),
  ('다이어트',   '스포츠'),
  ('축구',       '스포츠'),
  -- 여행/언어
  ('여행',       '여행/언어'),
  ('언어교환',   '여행/언어'),
  ('해외문화',   '여행/언어'),
  -- 라이프스타일
  ('패션',       '라이프스타일'),
  ('봉사활동',   '라이프스타일'),
  ('맛집',       '라이프스타일')
on conflict (name) do nothing;

-- ----------------------------------------------------------------
-- 2. encyclopedia_entries (한국 문화 5개, ko/en/ja)
-- ----------------------------------------------------------------
insert into public.encyclopedia_entries (category, country, title, content) values

  ('음식', 'KR',
    '{"ko": "김치", "en": "Kimchi", "ja": "キムチ"}',
    '{"ko": "김치는 한국의 대표적인 발효 음식으로, 배추나 무를 소금에 절여 고춧가루, 마늘, 생강 등 양념과 함께 발효시킨 것입니다. 깊은 감칠맛과 매운맛이 특징이며 한국인의 식탁에서 빠질 수 없는 반찬입니다.", "en": "Kimchi is Korea''s representative fermented food, made by salting cabbage or radish and fermenting it with seasonings like red pepper flakes, garlic, and ginger. Known for its deep umami and spicy flavor, it is an essential side dish on Korean tables.", "ja": "キムチは韓国の代表的な発酵食品で、白菜や大根を塩漬けにし、唐辛子・ニンニク・生姜などで漬け込んだものです。深いうまみと辛みが特徴で、韓国の食卓には欠かせない副菜です。"}'
  ),

  ('전통의상', 'KR',
    '{"ko": "한복", "en": "Hanbok", "ja": "韓服"}',
    '{"ko": "한복은 한국의 전통 의상으로, 곡선미와 화려한 색감이 특징입니다. 여성 한복은 저고리와 치마로, 남성 한복은 저고리와 바지로 구성됩니다. 오늘날에는 명절이나 특별한 행사 때 즐겨 입습니다.", "en": "Hanbok is Korea''s traditional clothing, known for its graceful curves and vibrant colors. Women''s hanbok consists of a jeogori (jacket) and chima (skirt), while men''s hanbok pairs a jeogori with baji (trousers). Today it is commonly worn during holidays and special occasions.", "ja": "韓服（ハンボク）は韓国の伝統衣装で、曲線美と鮮やかな色彩が特徴です。女性用は上着（チョゴリ）とスカート（チマ）、男性用はチョゴリとズボン（パジ）で構成されます。現代では名節や特別な行事の際に着用されます。"}'
  ),

  ('언어', 'KR',
    '{"ko": "한글", "en": "Hangul", "ja": "ハングル"}',
    '{"ko": "한글은 조선 4대 왕 세종대왕이 1443년에 창제한 한국의 문자 체계입니다. 총 24개의 자모(자음 14개, 모음 10개)로 구성되어 있으며, 과학적이고 체계적인 설계 덕분에 배우기 쉬운 문자로 세계적으로 인정받고 있습니다.", "en": "Hangul is the Korean writing system created in 1443 by King Sejong the Great. Composed of 24 letters (14 consonants and 10 vowels), it is recognized worldwide as a scientifically designed and easy-to-learn script.", "ja": "ハングルは1443年に朝鮮第4代王・世宗大王が創製した韓国の文字体系です。14の子音と10の母音からなる計24文字で構成されており、科学的で体系的な設計のため、習得しやすい文字として世界的に認められています。"}'
  ),

  ('명절', 'KR',
    '{"ko": "추석", "en": "Chuseok", "ja": "チュソク（秋夕）"}',
    '{"ko": "추석은 한국의 대표적인 추수감사 명절로, 음력 8월 15일에 지냅니다. 가족이 모여 차례를 지내고, 송편을 빚으며, 강강술래 등 전통 놀이를 즐깁니다. 한국인에게 설날과 함께 가장 중요한 명절입니다.", "en": "Chuseok is Korea''s major harvest festival celebrated on the 15th day of the 8th lunar month. Families gather to perform ancestral rites, make songpyeon (rice cakes), and enjoy traditional games like ganggangsullae. Along with Seollal, it is one of the most important holidays for Koreans.", "ja": "チュソク（秋夕）は韓国の代表的な秋の収穫祭で、旧暦8月15日に行われます。家族が集まって祭祀を行い、松餅（ソンピョン）を作り、カンガンスルレなどの伝統遊びを楽しみます。ソルラルと並ぶ韓国最大の名節です。"}'
  ),

  ('명절', 'KR',
    '{"ko": "설날", "en": "Seollal", "ja": "ソルラル（旧正月）"}',
    '{"ko": "설날은 한국의 음력 새해 첫날로, 가족이 한자리에 모여 조상에게 차례를 지내고 세배를 드리는 날입니다. 떡국을 먹으며 한 살 더 먹는다고 여기며, 어른들께 세뱃돈을 받는 풍습이 있습니다.", "en": "Seollal is the Korean Lunar New Year, a day when families gather to perform ancestral rites and bow to elders. Eating tteokguk (rice cake soup) symbolizes gaining a year of age, and children receive sebaedon (New Year''s money) from adults.", "ja": "ソルラルは韓国の旧正月で、家族が集まり先祖に祭祀を行い、年長者にお辞儀（セベ）をする日です。トックク（餅スープ）を食べることで一つ年を重ねるとされ、子どもたちは大人からお年玉（セベトン）をもらう風習があります。"}'
  )

on conflict do nothing;

-- ----------------------------------------------------------------
-- 3. events (시연용 3개)
-- ----------------------------------------------------------------
insert into public.events (title, description, event_date, location, image_url, created_by) values

  (
    '한국 전통 음식 만들기 체험',
    '외국인 친구들과 함께 김치, 잡채, 전 등 한국 전통 음식을 직접 만들어보는 체험 행사입니다. 재료는 모두 제공되며, 참가비는 무료입니다.',
    '2026-04-20 14:00:00+09',
    '서울시 강남구 테헤란로 문화센터',
    null,
    null
  ),

  (
    '영어 회화 스터디 모임',
    '영어가 모국어인 친구들과 한국인 학생들이 함께하는 영어 회화 스터디입니다. 자유 주제로 이야기하며 자연스럽게 언어 교환이 이루어집니다.',
    '2026-04-18 20:00:00+09',
    'Zoom 온라인 (링크는 참가 신청 후 제공)',
    null,
    null
  ),

  (
    '봄맞이 한강 피크닉',
    '따뜻한 봄날 한강에서 다양한 나라 친구들과 함께하는 피크닉입니다. 각자 나라의 음식을 가져와 나눠 먹으며 문화를 교류해요!',
    '2026-04-27 11:00:00+09',
    '서울 한강공원 여의도 지구 (여의나루역 1번 출구)',
    null,
    null
  )

on conflict do nothing;
