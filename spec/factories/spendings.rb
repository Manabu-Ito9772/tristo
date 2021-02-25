FactoryBot.define do
  factory :spending do
    genre { 0 }
    sequence(:description) { |n| "TestSpending#{n}" }
    sequence(:cost) { "300" }
    association :info_block, factory: :info_block
  end
end
