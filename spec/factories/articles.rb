FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "TestTitle#{n}" }
    sequence(:description) { |n| "TestDescription#{n}" }
    status { 0 }
    start_date { Time.current }
    end_date { Time.current.tomorrow }
    association :region
  end
end
