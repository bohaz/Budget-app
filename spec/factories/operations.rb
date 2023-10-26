FactoryBot.define do
  factory :operation do
    name { Faker::Commerce.product_name }
    amount { Faker::Commerce.price(range: 0..1000) }
    association :author, factory: :user
    group
    trait :without_group do
      group { nil }
    end
  end
end
