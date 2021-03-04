FactoryBot.define do
  factory :info_block do
    sequence(:event) { |n| "TestEvent#{n}" }
    sequence(:place) { |n| "TestPlace#{n}" }
    sequence(:place_info) { "https://manabu-ito.hatenablog.com/archive" }
    sequence(:comment) { |n| "TestComment#{n}" }
    position { 0 }
    arriving_time { Time.current }
    leaving_time { Time.current + 10.minutes }

    trait :normal do
      after(:build) do |info_block|
        info_block.spendings << build(:spending)
        info_block.spendings << build(:spending, :activity)
        info_block.spendings << build(:spending, :food)
        info_block.spendings << build(:spending, :souvenir)
        info_block.spendings << build(:spending, :accommodation)
        info_block.spendings << build(:spending, :other)
        info_block.transportations << build(:transportation)
      end
    end

    trait :only_with_event do
      place { nil }
      place_info { nil }
      comment { nil }
      arriving_time { nil }
      leaving_time { nil }
    end

    trait :without_transportation_cost do
      after(:build) do |info_block|
        info_block.transportations << build(:transportation, :walking)
        info_block.transportations << build(:transportation)
      end
    end

    trait :without_transportation_description do
      after(:build) do |info_block|
        info_block.transportations << build(:transportation, :car, description: nil)
        info_block.transportations << build(:transportation, description: nil)
        info_block.transportations << build(:transportation, :bus, description: nil)
        info_block.transportations << build(:transportation, :subway, description: nil)
        info_block.transportations << build(:transportation, :ship, description: nil)
        info_block.transportations << build(:transportation, :plane, description: nil)
        info_block.transportations << build(:transportation, :bicycle, description: nil)
        info_block.transportations << build(:transportation, :motorcycle, description: nil)
        info_block.transportations << build(:transportation, :other, description: nil)
      end
    end
  end
end
