require 'rails_helper'

RSpec.describe FoodInventory, type: :model do
  it 'is valid with valid attributes' do
    user = create(:user)
    inventory = create(:inventory, user: user)
    food = create(:food, user: user)
    food_inventory = create(:food_inventory, inventory: inventory, food: food)
    expect(food_inventory).to be_valid
  end

  it 'is not valid without a quantity' do
    food_inventory = build(:food_inventory, quantity: nil)
    expect(food_inventory).to_not be_valid
  end

  it 'belongs to an inventory' do
    association = FoodInventory.reflect_on_association(:inventory)
    expect(association.macro).to eq(:belongs_to)
  end

  it 'belongs to a food' do
    association = FoodInventory.reflect_on_association(:food)
    expect(association.macro).to eq(:belongs_to)
  end
end
