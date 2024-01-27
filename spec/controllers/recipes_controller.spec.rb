# spec/controllers/recipes_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
    let(:user) { create(:user) } 
    describe "GET #new" do
    it "assigns a new recipe as @recipe" do
      sign_in user
      get :new
      expect(assigns(:recipe)).to be_a_new(Recipe)
    end
end
  
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
      create_list(:recipe_food, 3, recipe: recipe)

      sign_in create(:user)
      get :show, params: { id: recipe.id }
      expect(response).to render_template("show")
    end
  end

  describe "POST #create" do
  context "with valid params" do
    let(:valid_attributes) { attributes_for(:recipe) }

    it "creates a new Recipe" do
      sign_in user
      expect {
        post :create, params: { recipe: valid_attributes }
      }.to change(Recipe, :count).by(1)
    end

    it "assigns a newly created recipe as @recipe" do
      sign_in user
      post :create, params: { recipe: valid_attributes }
      expect(assigns(:recipe)).to be_a(Recipe)
      expect(assigns(:recipe)).to be_persisted
    end

    it "redirects to the created recipe" do
      sign_in user
      post :create, params: { recipe: valid_attributes }
      expect(response).to redirect_to(Recipe.last)
    end
  end
end

describe "DELETE #destroy" do
let(:recipe) { create(:recipe, user: user) }

it "destroys the requested recipe" do
  sign_in user
  expect {
    delete :destroy, params: { id: recipe.to_param }
  }.to change(Recipe, :count).by(-1)
end

it "redirects to the recipes list" do
  sign_in user
  delete :destroy, params: { id: recipe.to_param }
  expect(response).to redirect_to(recipes_url)
end
end


  # Add more controller action tests for new, create, edit, update, destroy, etc.
end
