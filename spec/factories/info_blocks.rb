FactoryBot.define do
  factory :info_block do
    day { 0 }
    arriving_time { Time.current }
    leaving_time { Time.current + 10.minutes }
    sequence(:event) { |n| "TestEvent#{n}" }
    sequence(:place) { |n| "TestPlace#{n}" }
    sequence(:place_info) { "https://manabu-ito.hatenablog.com/archive" }
    sequence(:comment) { |n| "TestComment#{n}" }
    position { 0 }
    association :article
    factory :with_cost do
      after(:create) do | info_block |
        create(:spending, info_block: info_block)
        create(:transportation, info_block: info_block)
      end
    end
  end
end
