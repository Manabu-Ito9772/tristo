FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    sequence(:description) { |n| "Description#{n}" }
    password { 'password' }

    trait :another_user do
      name { 'AnotherUser' }
      email { 'another@another.com' }
      description { 'AnotherDescription' }
      password { 'password' }
    end

    trait :third_user do
      name { 'ThirdUser' }
      email { 'third@third.com' }
      description { 'ThirdDescription' }
      password { 'password' }
    end
  end
end
