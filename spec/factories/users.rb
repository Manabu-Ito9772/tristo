FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:description) { |n| "Description#{n}" }
    password { 'password' }
  end
end
