FactoryBot.define do
  factory :transportation do
    means { 0 }
    sequence(:description) { |n| "TestTransportation#{n}" }
    sequence(:cost) { "300" }
    association :info_block, factory: :info_block
  end
end
