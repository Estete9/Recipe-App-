class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  before_action :authenticate_user!, except: [:public]

  def public
    @public_page = true
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    render :index
  end

  def shopping_list
    @recipe = Recipe.includes(:recipe_foods).find(params[:recipe_id])
    @inventory = Inventory.includes(:food_inventories).find(params[:inventory_id])

    @missing_foods = calculate_quantity_differences(@recipe, @inventory)
    @total_missing_foods = calculate_total_missing_foods(@missing_foods)
    @total_price = calculate_total_price(@missing_foods)
  end

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
    @recipe_food = @recipe.recipe_foods.includes(:food)
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # POST /recipes or /recipes.json
  def create
    @user = current_user
    @recipe = Recipe.new(recipe_params.merge(user: @user))

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def general_shopping_list
    @recipes = current_user.recipes
    @inventories = current_user.inventories

    @missing_foods = general_calculate_quantity_differences(@recipes, @inventories)
    @total_missing_foods = @missing_foods.length
    @total_price = calculate_total_price(@missing_foods)

 
  end

  private

  def calculate_total_missing_foods(differences)
    total_quantity = 0

    differences.each do |item|
      total_quantity += item[:quantity_difference]
    end

    total_quantity
  end

  def calculate_total_price(differences)
    total_price = 0
    differences.each do |item|
      total_price += item[:quantity_difference] * item[:price]
    end

    total_price
  end

  def calculate_quantity_differences(recipe, inventory)
    differences = []

    recipe.recipe_foods.each do |recipe_food|
      food_inventory = inventory.food_inventories.find_by(food: recipe_food.food)

      quantity_difference =
        if food_inventory.nil?
          recipe_food.quantity
        else
          recipe_food.quantity - food_inventory.quantity
        end

        differences << {
          food: recipe_food.food,
          quantity_difference: quantity_difference,
          price: recipe_food.food.price 
        }
    end

    differences
  end
################################

def general_calculate_quantity_differences(recipes, inventories)
  @unique_foods = {}
  differences = []
  

  recipes.each do |recipe|
    inventories.each do |inventory|
      food_inventories = inventory.food_inventories.where(food: recipe.recipe_foods.map(&:food))

      food_inventories.each do |food_inventory|
        food = food_inventory.food
        quantity_difference = recipe.recipe_foods.find_by(food: food).quantity - food_inventory.quantity

        if quantity_difference.positive?
          if @unique_foods.key?(food.id)
          @unique_foods[food.id][:quantity_difference] += quantity_difference
        
          else
            @unique_foods[food.id] = {
              food: food,
              quantity_difference: quantity_difference,  
            }
            
          end
          @unique_foods[food.id][:price] = food.price
        end
        
      end
    end
  end
  differences = @unique_foods.values
  differences
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user)
  end
end
