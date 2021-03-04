FactoryBot.define do
  factory :spending do
    genre { 0 }
    sequence(:description) { |n| "Touring#{n}" }
    sequence(:cost) { '100' }

    trait :activity do
      genre { 1 }
      sequence(:description) { |n| "Activity#{n}" }
    end

    trait :food do
      genre { 2 }
      sequence(:description) { |n| "Food#{n}" }
    end

    trait :souvenir do
      genre { 3 }
      sequence(:description) { |n| "Souvenir#{n}" }
    end

    trait :accommodation do
      genre { 4 }
      sequence(:description) { |n| "Accommdation#{n}" }
    end

    trait :other do
      genre { 5 }
      sequence(:description) { |n| "Other#{n}" }
    end
  end
end
