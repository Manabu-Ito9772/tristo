FactoryBot.define do
  factory :transportation do
    means { 2 }
    sequence(:description) { |n| "Taxi#{n}" }
    sequence(:cost) { '100' }

    trait :walking do
      means { 0 }
      sequence(:description) { |n| "walking#{n}" }
      cost { nil }
    end

    trait :car do
      means { 1 }
      sequence(:description) { |n| "Car#{n}" }
    end

    trait :bus do
      means { 3 }
      sequence(:description) { |n| "Bus#{n}" }
    end

    trait :subway do
      means { 4 }
      sequence(:description) { |n| "Train#{n}" }
    end

    trait :ship do
      means { 5 }
      sequence(:description) { |n| "Ship#{n}" }
    end

    trait :plane do
      means { 6 }
      sequence(:description) { |n| "Plane#{n}" }
    end

    trait :bicycle do
      means { 7 }
      sequence(:description) { |n| "Bicycle#{n}" }
    end

    trait :motorcycle do
      means { 8 }
      sequence(:description) { |n| "Motorcycle#{n}" }
    end

    trait :other do
      means { 9 }
      sequence(:description) { |n| "other#{n}" }
    end
  end
end
