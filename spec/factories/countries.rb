FactoryBot.define do
  factory :country do
    sequence(:name) { |n| "Country#{n}" }
    sequence(:currency) { |n| "Currency#{n}" }
  end

  trait :normal do
    after(:build) do |country|
      country.regions << build(:region)
      country.regions << build(:region)
    end
  end

  trait :japan do
    name { '日本' }
    currency { '円' }
    after(:build) do |country|
      country.articles << build(:article, :tokyo)
    end
  end

  trait :japan_tokyo_kanagawa do
    name { '日本' }
    currency { '円' }
    after(:build) do |country|
      country.regions << build(:region, :tokyo)
      country.regions << build(:region, :kanagawa)
    end
  end

  trait :domestic do
    name { '日本' }
    currency { '円' }
    after(:build) do |country|
      country.regions << build(:region, :tokyo)
      country.regions << build(:region, :osaka)
      country.regions << build(:region, :fukuoka)
      country.regions << build(:region, :okinawa)
    end
  end

  trait :usa do
    name { 'アメリカ' }
    currency { 'ドル' }
    after(:build) do |country|
      country.regions << build(:region, :newyork)
      country.regions << build(:region, :california)
      country.regions << build(:region, :hawaii)
    end
  end

  trait :france do
    name { 'フランス' }
    currency { 'ユーロ' }
    after(:build) do |country|
      country.regions << build(:region, :paris)
    end
  end

  trait :china do
    name { '中国' }
    currency { '元' }
  end
end
