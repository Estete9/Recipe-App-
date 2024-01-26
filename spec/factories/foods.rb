# spec/factories/foods.rb
FactoryBot.define do
  factory :food do
    name { Faker::Lorem.word }
    measurement_unit { 'unit' }
    price { Faker::Number.decimal(l_digits: 2) }

    association :user

    after(:create) do |food|
      create_list(:recipe_food, 3, food: food)
      create_list(:recipe, 3, foods: [food])
    end
  end
end
