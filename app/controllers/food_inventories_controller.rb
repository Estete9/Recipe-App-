class FoodInventoriesController < ApplicationController

  def new
    @food_inventory = FoodInventory.new
    @inventory_id = params[:inventory_id]
    @foods = Food.all
  end

end
