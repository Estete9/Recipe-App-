FactoryBot.define do
  factory :inventory do
    name { Faker::Lorem.word }
    description { Faker::Lorem.sentence }

    association :user, factory: :user

    after(:create) do |inventory|
      create_list(:food_inventory, 3, inventory: inventory)
      create_list(:food, 3, inventories: [inventory])
    end
  end
end
