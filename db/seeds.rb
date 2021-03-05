# Country.create!(name: '日本', currency: '円')
#
# prefectures = [
#   '未選択', '北海道', '青森県', '岩手県', '宮城県', '秋田県', '山形県', '福島県',
#   '茨城県', '栃木県', '群馬県', '埼玉県', '千葉県', '東京都', '神奈川県',
#   '新潟県', '富山県', '石川県', '福井県', '山梨県', '長野県', '岐阜県', '静岡県', '愛知県',
#   '三重県', '滋賀県', '京都府', '大阪府', '兵庫県', '奈良県', '和歌山県',
#   '鳥取県', '島根県', '岡山県', '広島県', '山口県', '徳島県', '香川県', '愛媛県', '高知県',
#   '福岡県', '佐賀県', '長崎県', '熊本県', '大分県', '宮崎県', '鹿児島県', '沖縄県'
# ]
#
# prefectures.each do |prefecture|
#   Country.first.regions.create!(name: prefecture)
# end

3.times do
  country = Country.create!(
    name: Faker::Nation.nationality,
    currency: Faker::Nation.language
  )

  5.times do
    region = country.regions.create!(
      name: Faker::Nation.capital_city
    )

    article = region.articles.create!(
      title: Faker::Movies::StarWars.character,
      description: Faker::Movies::BackToTheFuture.quote,
      map: '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>',
      start_date: Date.today,
      end_date: Date.tomorrow
    )

    n = rand(1..5)
    n.times do |n|
      day = article.days.create(number: n + 1)

      m = rand(2..5)
      m.times do
        info_block = day.info_blocks.create(
          event: Faker::JapaneseMedia::DragonBall.character,
          place: Faker::JapaneseMedia::OnePiece.character,
          comment: Faker::Movies::BackToTheFuture.quote,
          position: 1,
          arriving_time: Time.now,
          leaving_time: Time.now + m.minutes,
        )

        x = rand(0..3)
        x.times do
          info_block.spendings.create(
            genre: rand(0..5),
            description: Faker::JapaneseMedia::Naruto.character,
            cost: rand(100..2000)
          )
        end

        y = rand(1..2)
        y.times do
          info_block.transportations.create(
            means: rand(0..9),
            description: Faker::JapaneseMedia::Doraemon.character,
            cost: rand(100..2000)
          )
        end
      end
    end
  end
end
