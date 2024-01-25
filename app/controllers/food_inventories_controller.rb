class FoodInventoriesController < ApplicationController

  def new
    @food_inventory = FoodInventory.new
    @inventory_id = params[:inventory_id]
    @foods = Food.all
  end

  def create
    @food_inventory = FoodInventory.new(food_inventory_params)
    if @food_inventory.save
      redirect_to inventory_path(id: @food_inventory.inventory_id)
    else
      render :new, alert: 'Failed to add ingredient'
    end
  end

  def destroy
    # @inventory_id = params[:inventory_id]
    @food_inventory = FoodInventory.find(params[:id])

    @food_inventory.destroy!

    redirect_to inventory_path(@food_inventory.inventory_id)
  end

  private

  def food_inventory_params
    params.require(:food_inventory).permit(:quantity, :inventory_id, :food_id)
  end

end
