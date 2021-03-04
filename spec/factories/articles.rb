FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "TestTitle#{n}" }
    sequence(:description) { |n| "TestDescription#{n}" }
    status { 0 }
    start_date { Date.today }
    end_date { Date.tomorrow }
    association :region

    trait :normal do
      after(:build) do |article|
        article.days << build(:day, :normal)
        article.days << build(:day, :day_two)
        article.days << build(:day, :day_three)
      end
    end

    trait :only_with_event do
      after(:build) do |article|
        article.days << build(:day, :only_with_event)
      end
    end

    trait :without_transportation_cost do
      after(:build) do |article|
        article.days << build(:day, :without_transportation_cost)
      end
    end

    trait :without_transportation_description do
      after(:build) do |article|
        article.days << build(:day, :without_transportation_description)
      end
    end
  end
end
