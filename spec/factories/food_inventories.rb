FactoryBot.define do
  factory :food_inventory do
    quantity { Faker::Number.between(from: 1, to: 100) }
    association :inventory
    association :food
    # Add other attributes as needed
  end
end
