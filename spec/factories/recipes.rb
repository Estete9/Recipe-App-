FactoryBot.define do
  factory :recipe do
    name { Faker::Lorem.word }
    preparation_time { "#{Faker::Number.between(from: 1, to: 100)} minutes" }
    cooking_time { "#{Faker::Number.between(from: 1, to: 3)} hours" }
    description { Faker::Lorem.sentence }
    public { true }

    # Assuming you have a user factory for associating the recipe with a user
    association :user

    # Create associations with recipe_foods and foods
    after(:create) do |recipe|
      create_list(:recipe_food, 3, recipe: recipe)
      create_list(:food, 3, recipes: [recipe])
    end
  end
end
