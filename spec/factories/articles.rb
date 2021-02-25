FactoryBot.define do
  factory :article do
    sequence(:title) { |n| "TestTitle#{n}" }
    sequence(:description) { |n| "TestDescription#{n}" }
    status { 0 }
    start_date { Date.today }
    end_date { Date.tomorrow }
    association :region
  end
end
