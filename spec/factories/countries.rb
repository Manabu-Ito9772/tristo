FactoryBot.define do
  factory :country do
    sequence(:name) { |n| "Country#{n}" }
    sequence(:currency) { |n| "Currency#{n}" }
  end
end
