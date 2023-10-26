FactoryBot.define do
  factory :group do
    name { Faker::Lorem.unique.word }
    icon { ['fas fa-car', 'fas fa-bicycle', 'fas fa-bus'].sample }
    user
  end
end
