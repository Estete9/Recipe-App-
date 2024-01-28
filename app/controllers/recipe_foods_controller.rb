class RecipeFoodsController < ApplicationController
  def index
    @recipe_foods = RecipeFood.where(recipe_id: params[:recipe_id])
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.where(food_id: params[:food_id])
  end

  def new
    @recipe_food = RecipeFood.new
    @recipe_id = params[:recipe_id]
    @foods = Food.all
  end

  def create
    @recipe_food = RecipeFood.new(recipe_food_params)
    if @recipe_food.save
      flash[:success] = 'Ingredient was successfully added.'
      redirect_to recipe_path(id: @recipe_food.recipe_id)
    else
      render :new, alert: 'Failed to add ingredient'
    end
  end

  def destroy
    @recipe_id = params[:recipe_id]
    @recipe_food = RecipeFood.find(params[:id])
    return unless @recipe_food.destroy

    flash[:success] = 'Ingredient was successfully deleted.'
    redirect_to recipe_path(id: @recipe_food.recipe_id)
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :recipe_id, :food_id)
  end
end
