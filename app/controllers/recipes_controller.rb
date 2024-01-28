class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show destroy]
  before_action :authenticate_user!, except: [:public]

  def public
    @public_page = true
    @recipes = Recipe.where(public: true).order(created_at: :desc)
    render :index
  end

  def shopping_list_inventory
    load_recipe_and_inventories

    respond_to(&:html)
  end

  def shopping_list
    load_recipe_and_inventory
    @missing_foods = calculate_quantity_differences(@recipe, @inventory)
    @total_missing_foods = @missing_foods.length
    @total_price = calculate_total_price(@missing_foods)
  end

  def index
    @recipes = Recipe.where(user_id: current_user.id)
  end

  def show
    load_recipe
    @recipe_food = @recipe.recipe_foods.includes(:food)
    @inventories = Inventory.where(user_id: current_user.id)
  end

  def new
    @recipe = Recipe.new
  end

  def create
    @user = current_user
    @recipe = Recipe.new(recipe_params.merge(user: @user))

    respond_to do |format|
      handle_recipe_saving(format)
    end
  end

  def destroy
    @recipe.destroy!

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def general_shopping_list
    load_user_recipes_and_inventories
    @missing_foods = general_calculate_quantity_differences(@recipes, @inventories)
    @total_missing_foods = @missing_foods.length
    @total_price = calculate_total_price(@missing_foods)
  end

  private

  def load_recipe_and_inventories
    puts "Recipe ID from params: #{params[:recipe_id]}"
    @recipe = Recipe.includes(:recipe_foods).find(params[:recipe_id])
    @inventories = Inventory.where(user_id: current_user.id)
  end

  def load_recipe
    @recipe = Recipe.includes(:recipe_foods).find(params[:id])
  end

  def load_recipe_and_inventory
    @recipe = Recipe.includes(:recipe_foods).find(params[:recipe_id])
    @inventory = Inventory.includes(:food_inventories).find(params[:inventory_id])
  end

  def load_user_recipes_and_inventories
    @recipes = current_user.recipes
    @inventories = current_user.inventories
  end

  def handle_recipe_saving(format)
    if @recipe.save
      format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
      format.json { render :show, status: :created, location: @recipe }
    else
      format.html { render :new, status: :unprocessable_entity }
      format.json { render json: @recipe.errors, status: :unprocessable_entity }
    end
  end

  def calculate_total_price(differences)
    differences.sum { |item| item[:price] }
  end

  def calculate_quantity_differences(recipe, inventory)
    differences = []

    recipe.recipe_foods.each do |recipe_food|
      food_inventory = inventory.food_inventories.find_by(food: recipe_food.food)
      quantity_difference = calculate_quantity_difference(recipe_food, food_inventory)
      next unless quantity_difference.positive?

      differences << {
        food: recipe_food.food,
        quantity_difference:,
        price: recipe_food.food.price * quantity_difference
      }
    end

    differences
  end

  def calculate_quantity_difference(recipe_food, food_inventory)
    food_inventory.nil? ? recipe_food.quantity : recipe_food.quantity - food_inventory.quantity
  end

  def general_calculate_quantity_differences(recipes, inventories)
    unique_foods = {}

    recipes.each do |recipe|
      inventories.each do |inventory|
        calculate_general_quantity_differences(unique_foods, recipe, inventory)
      end
    end

    unique_foods.values.map do |unique_food|
      {
        food: unique_food[:food],
        quantity_difference: unique_food[:quantity_difference],
        price: unique_food[:quantity_difference] * unique_food[:price]
      }
    end
  end

  def calculate_general_quantity_differences(unique_foods, recipe, inventory)
    food_inventories = inventory.food_inventories.where(food: recipe.recipe_foods.map(&:food))

    food_inventories.each do |food_inventory|
      food = food_inventory.food
      quantity_difference = if food_inventory.nil?
                              recipe.recipe_foods.find_by(food:).quantity
                            else
                              recipe.recipe_foods.find_by(food:).quantity - food_inventory.quantity
                            end

      next unless quantity_difference.positive?

      if unique_foods.key?(food.id)
        unique_foods[food.id][:quantity_difference] += quantity_difference
      else
        unique_foods[food.id] = {
          food:,
          quantity_difference:,
          price: food.price
        }
      end
    end
  end

  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  def recipe_params
    params.require(:recipe).permit(:name, :preparation_time, :cooking_time, :description, :public, :user)
  end
end
