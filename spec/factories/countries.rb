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
end
