FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "TestTitle#{n}" }
    sequence(:description) { |n| "TestDescription#{n}" }
    map { '<iframe src="https://www.google.com/maps/d/u/0/embed?mid=17HzQVLk9-3JyLYxvCBQmvWjtlaomn4xd" width="640" height="480"></iframe>' }
    status { 'published' }
    start_date { Date.today }
    end_date { Date.tomorrow }
    association :user

    trait :normal do
      association :country
      after(:build) do |article|
        article.regions << build(:region, :normal)
        article.tags << build(:tag)
        article.days << build(:day, :normal)
        article.days << build(:day, :day_two)
        article.days << build(:day, :day_three)
      end
    end

    trait :another_user do
      association :user, :another_user
      association :country
      after(:build) do |article|
        article.regions << build(:region, :normal)
        article.tags << build(:tag)
        article.days << build(:day, :normal)
        article.days << build(:day, :day_two)
        article.days << build(:day, :day_three)
      end
    end

    trait :without_info do
      description { nil }
      start_date { nil }
      end_date { nil }
      association :country
    end

    trait :tokyo do
      after(:build) do |article|
        article.regions << build(:region, :tokyo)
      end
    end

    trait :only_with_event do
      association :country
      after(:build) do |article|
        article.days << build(:day, :only_with_event)
      end
    end

    trait :without_transportation_cost do
      association :country
      after(:build) do |article|
        article.days << build(:day, :without_transportation_cost)
      end
    end

    trait :without_transportation_cost_all do
      association :country
      after(:build) do |article|
        article.days << build(:day, :without_transportation_cost_all)
      end
    end

    trait :without_transportation_description do
      association :country
      after(:build) do |article|
        article.days << build(:day, :without_transportation_description)
      end
    end
  end
end
