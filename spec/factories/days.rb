FactoryBot.define do
  factory :day do
    number { 1 }

    trait :day_two do
      number { 2 }
      after(:build) do |day|
        day.blocks << build(:block, :normal)
      end
    end

    trait :day_three do
      number { 3 }
      after(:build) do |day|
        day.blocks << build(:block, :normal)
      end
    end

    trait :normal do
      after(:build) do |day|
        day.blocks << build(:block, :normal)
      end
    end

    trait :only_with_event do
      after(:build) do |day|
        day.blocks << build(:block, :only_with_event)
      end
    end

    trait :without_transportation_cost do
      after(:build) do |day|
        day.blocks << build(:block, :without_transportation_cost)
      end
    end

    trait :without_transportation_cost_all do
      after(:build) do |day|
        day.blocks << build(:block, :without_transportation_cost_all)
      end
    end

    trait :without_transportation_description do
      after(:build) do |day|
        day.blocks << build(:block, :without_transportation_description)
      end
    end
  end
end
