require 'rails_helper'

RSpec.describe RecipeFoodsController, type: :controller do
  let(:user) { create(:user) }
  let(:recipe) { create(:recipe, user: user) }
  let(:food) { create(:food) }
  let(:recipe_food) { create(:recipe_food, recipe: recipe, food: food) }

  before { sign_in user }

  describe "POST #create" do
    context "with valid params" do
      it "creates a new recipe_food" do
        expect {
          post :create, params: { recipe_food: attributes_for(:recipe_food, recipe_id: recipe.id, food_id: food.id) }
        }
      end

      it "redirects to the recipe show page" do
        post :create, params: { recipe_food: attributes_for(:recipe_food, recipe_id: recipe.id, food_id: food.id) }
        expect(response).to redirect_to(recipe_path(recipe))
      end
    end

    context "with invalid params" do
      it "does not create a new recipe_food" do
        expect {
          post :create, params: { recipe_food: attributes_for(:recipe_food, quantity: nil, recipe_id: nil, food_id: food.id) }
        }.to_not change(RecipeFood, :count)
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested recipe_food" do
      recipe_food # Create the recipe_food
      expect {
        delete :destroy, params: { id: recipe_food.id, recipe_id: recipe.id }
      }
    end

    it "redirects to the recipe show page" do
      delete :destroy, params: { id: recipe_food.id, recipe_id: recipe.id }
      expect(response).to redirect_to(recipe_path(recipe))
    end
  end
end