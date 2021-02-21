FactoryBot.define do
  factory :region do
    sequence(:name) { |n| "Region#{n}" }
    association :country
  end
end
