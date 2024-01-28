require 'rails_helper'
require 'pry'

RSpec.feature "Recipes", type: :feature do
    let(:user) { create(:user) }
    let!(:recipe) { create(:recipe, user: user) }
    let(:food) { create(:food, user: user) }
    let(:recipe_food) {create(:recipe_food, recipe: recipe, food: food )}
  
    before { login_as(user, scope: :user) }
  
    scenario "User views the recipe index" do
      visit recipes_path
      expect(page).to have_content("Recipes")
      expect(page).to have_content(recipe.name)
    end
  
    scenario "User creates a new recipe" do
      visit recipes_path
      click_link "Add Recipe"
  
      fill_in "Name", with: "New Recipe"
      fill_in "Preparation time", with: "30 minutes"
      fill_in "Cooking time", with: "1 hour"
      fill_in "Description", with: "Delicious new recipe!"
      check "Public"
      click_button "Create Recipe"
  
      expect(page).to have_content("Recipe was successfully created.")
      expect(page).to have_content("New Recipe")
    end
  
    # Add more scenarios as needed, covering edit, update, delete, etc.
  end