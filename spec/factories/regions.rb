FactoryBot.define do
  factory :region do
    sequence(:name) { |n| "Region#{n}" }

    trait :normal do
      association :country
    end

    trait :tokyo do
      name { '東京' }
      association :country
    end

    trait :kanagawa do
      name { '神奈川' }
      association :country
    end
  end
end
