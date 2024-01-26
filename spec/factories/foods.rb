# spec/factories/foods.rb
FactoryBot.define do
  factory :food do
    name { 'Sample Food' }
    measurement_unit { 'unit' }
    price { 10.99 }

    association :user

    after(:create) do |food|
      create_list(:recipe_food, 3, food: food)
      create_list(:recipe, 3, foods: [food])
    end
  end
end
