FactoryBot.define do
  factory :recipe do
    name { 'Sample Recipe' }
    preparation_time { '30 minutes' }
    cooking_time { '1 hour' }
    description { 'A delicious sample recipe' }
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
