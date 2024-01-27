# spec/controllers/recipes_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  describe "GET #index" do
    it "renders the index template" do
        # Include Devise test helpers to set up authentication
      sign_in create(:user)  
      get :index
      expect(response).to render_template("index")
    end

    # Add more controller action tests as needed
  end

  describe "GET #show" do
    it "renders the show template" do
      recipe = create(:recipe)
      get :show, params: { id: recipe.id }
      expect(response).to render_template("show")
    end
  end

  # Add more controller action tests for new, create, edit, update, destroy, etc.
end
