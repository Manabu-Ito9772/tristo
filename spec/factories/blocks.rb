FactoryBot.define do
  factory :block do
    sequence(:title) { |n| "TestEvent#{n}" }
    sequence(:place) { |n| "TestPlace#{n}" }
    sequence(:place_info) { "https://manabu-ito.hatenablog.com/archive" }
    sequence(:comment) { |n| "TestComment#{n}" }
    arriving_time { Time.current }
    leaving_time { Time.current + 10.minutes }
    position { 1 }

    trait :normal do
      after(:build) do |block|
        block.spendings << build(:spending)
        block.spendings << build(:spending, :activity)
        block.spendings << build(:spending, :food)
        block.spendings << build(:spending, :souvenir)
        block.spendings << build(:spending, :accommodation)
        block.spendings << build(:spending, :other)
        block.transportations << build(:transportation)
      end
    end

    trait :only_with_event do
      title { nil }
      place_info { nil }
      comment { nil }
      arriving_time { nil }
      leaving_time { nil }
    end

    trait :without_transportation_cost do
      after(:build) do |block|
        block.transportations << build(:transportation, :walking)
        block.transportations << build(:transportation)
      end
    end

    trait :without_transportation_cost_all do
      after(:build) do |block|
        block.spendings << build(:spending)
        block.transportations << build(:transportation, :walking)
        block.transportations << build(:transportation, :walking)
      end
    end

    trait :without_transportation_description do
      after(:build) do |block|
        block.transportations << build(:transportation, :car, description: nil)
        block.transportations << build(:transportation, description: nil)
        block.transportations << build(:transportation, :bus, description: nil)
        block.transportations << build(:transportation, :subway, description: nil)
        block.transportations << build(:transportation, :ship, description: nil)
        block.transportations << build(:transportation, :plane, description: nil)
        block.transportations << build(:transportation, :bicycle, description: nil)
        block.transportations << build(:transportation, :motorcycle, description: nil)
        block.transportations << build(:transportation, :other, description: nil)
      end
    end
  end
end
