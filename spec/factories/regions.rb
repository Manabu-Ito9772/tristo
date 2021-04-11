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

    trait :osaka do
      name { '大阪' }
      association :country
    end

    trait :fukuoka do
      name { '福岡' }
      association :country
    end

    trait :okinawa do
      name { '沖縄' }
      association :country
    end

    trait :newyork do
      name { 'ニューヨーク' }
      association :country
    end

    trait :california do
      name { 'カリフォルニア' }
      association :country
    end

    trait :hawaii do
      name { 'ハワイ' }
      association :country
    end

    trait :paris do
      name { 'パリ' }
      association :country
    end
  end
end
