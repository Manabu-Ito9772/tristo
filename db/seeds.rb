# countries = [
#   ['日本'], ['韓国'], ['台湾'], ['中国'], ['フィリピン'], ['ベトナム'], ['カンボジア'], ['タイ'],
#   'ミャンマー', 'マレーシア', 'シンガポール', 'インドネシア', 'インド', 'スリランカ', 'モルディブ',
#   'オーストラリア', 'ニュージーランド', 'ニューカレドニア', 'フィジー', 'タヒチ', 'アメリカ', 'カナダ', 'メキシコ', 'キューバ',
#   'ブラジル', 'イギリス', 'ドイツ', 'フランス', 'イタリア', 'スペイン', 'ポルトガル',
#   'オランダ', 'スイス', 'ロシア', 'ギリシャ', 'トルコ', 'アラブ首長国連邦', '南アフリカ',
# ]

countries = [
  ['日本', '円'], ['韓国', 'KRW'], ['台湾', 'TWD'], ['中国', '元']
]

countries.each do |country|
  Country.create!(name: country[0], currency: country[1])
end

japan_regions = [
  '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県', '茨城県',
  '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県', '新潟県', '富山県',
  '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県', '三重県',
  '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県', '鳥取県', '島根県',
  '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県', '高知県', '福岡県',
  '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県'
]

japan_regions.each do |region|
  Country.find_by(name: '日本').regions.create!(name: region)
end

korea_regions = [
  'ソウル特別市', '仁川広域市', '大田広域市', '光州広域市', '大邱広域市',
  '蔚山広域市', '釜山広域市', '世宗特別自治市', '済州特別自治道', '京畿道', '江原道',
  '忠清北道', '忠清南道', '慶尚北道', '慶尚南道', '全羅北道', '全羅南道'
]

korea_regions.each do |region|
  Country.find_by(name: '韓国').regions.create!(name: region)
end

taiwan_regions = [
  '台北市', '新北市', '桃園市', '台中市', '台南市', '高雄市', '新竹県',
  '苗栗県', '彰化県', '南投県', '雲林県', '嘉義県', '屏東県', '宜蘭県',
  '花蓮県', '台東県', '澎湖県', '金門県', '連江県', '基隆市', '新竹市', '嘉義市'
]

taiwan_regions.each do |region|
  Country.find_by(name: '台湾').regions.create!(name: region)
end

@user = User.create!(
  name: 'Sample User',
  email: 'sample@sample.com',
  password: 'password'
)

5.times do
  article = @user.articles.create!(
    country_id: 1,
    title: Faker::Movies::StarWars.character,
    description: Faker::Movies::BackToTheFuture.quote,
    map: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>',
    status: 'published',
    start_date: Date.today,
    end_date: Date.tomorrow
  )

  article.article_regions.create!(region_id: rand(1..24))
  article.article_regions.create!(region_id: rand(25..48))

  n = rand(1..5)
  n.times do |n|
    day = article.days.create(number: n + 1)

    m = rand(2..5)
    m.times do
      block = day.blocks.create(
        title: Faker::JapaneseMedia::DragonBall.character,
        place: Faker::JapaneseMedia::OnePiece.character,
        comment: Faker::Movies::BackToTheFuture.quote,
        arriving_time: Time.now,
        leaving_time: Time.now + m.minutes,
      )

      x = rand(0..3)
      x.times do
        block.spendings.create(
          genre: rand(0..5),
          description: Faker::JapaneseMedia::Naruto.character,
          cost: rand(100..2000)
        )
      end

      y = rand(1..2)
      y.times do
        block.transportations.create(
          means: rand(0..9),
          description: Faker::JapaneseMedia::Doraemon.character,
          cost: rand(100..2000)
        )
      end
    end
  end
end

5.times do
  article = @user.articles.create!(
    country_id: 2,
    title: Faker::Movies::StarWars.character,
    description: Faker::Movies::BackToTheFuture.quote,
    map: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>',
    status: 'published',
    start_date: Date.today,
    end_date: Date.tomorrow
  )

  article.article_regions.create!(region_id: rand(49..55))
  article.article_regions.create!(region_id: rand(56..66))

  n = rand(1..5)
  n.times do |n|
    day = article.days.create(number: n + 1)

    m = rand(2..5)
    m.times do
      block = day.blocks.create(
        title: Faker::JapaneseMedia::DragonBall.character,
        place: Faker::JapaneseMedia::OnePiece.character,
        comment: Faker::Movies::BackToTheFuture.quote,
        arriving_time: Time.now,
        leaving_time: Time.now + m.minutes,
      )

      x = rand(0..3)
      x.times do
        block.spendings.create(
          genre: rand(0..5),
          description: Faker::JapaneseMedia::Naruto.character,
          cost: rand(100..2000)
        )
      end

      y = rand(1..2)
      y.times do
        block.transportations.create(
          means: rand(0..9),
          description: Faker::JapaneseMedia::Doraemon.character,
          cost: rand(100..2000)
        )
      end
    end
  end
end

5.times do
  article = @user.articles.create!(
    country_id: 3,
    title: Faker::Movies::StarWars.character,
    description: Faker::Movies::BackToTheFuture.quote,
    map: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>',
    status: 'published',
    start_date: Date.today,
    end_date: Date.tomorrow
  )

  article.article_regions.create!(region_id: rand(67..75))
  article.article_regions.create!(region_id: rand(76..85))

  n = rand(1..5)
  n.times do |n|
    day = article.days.create(number: n + 1)

    m = rand(2..5)
    m.times do
      block = day.blocks.create(
        title: Faker::JapaneseMedia::DragonBall.character,
        place: Faker::JapaneseMedia::OnePiece.character,
        comment: Faker::Movies::BackToTheFuture.quote,
        arriving_time: Time.now,
        leaving_time: Time.now + m.minutes,
      )

      x = rand(0..3)
      x.times do
        block.spendings.create(
          genre: rand(0..5),
          description: Faker::JapaneseMedia::Naruto.character,
          cost: rand(100..2000)
        )
      end

      y = rand(1..2)
      y.times do
        block.transportations.create(
          means: rand(0..9),
          description: Faker::JapaneseMedia::Doraemon.character,
          cost: rand(100..2000)
        )
      end
    end
  end
end
