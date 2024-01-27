# spec/features/food_inventories_spec.rb
require 'rails_helper'

require 'pry'

RSpec.feature 'Food Inventories', type: :feature do
  let(:user) { create(:user) }
  let(:inventory) { create(:inventory, user: user) }
  let(:food) { create(:food, user: user) }

  before do
    # Instead of creating the associated records in the test, rely on the factories
    # This ensures that the associations are correctly set up
    # The factories will create the necessary associated records, including food_inventories
    login_as(user, scope: :user)
  end

  scenario 'User adds a new food to an inventory' do
    # Visit the page

    create(:food_inventory, inventory: inventory, food: food)

    visit new_food_inventory_path(inventory_id: inventory.id)

    # Explicitly wait for the dropdown to be present before interacting
    select_field = find('#food_inventory_food_id', wait: 20)


    # binding.pry

    select_field.click

    # Select the option using the visible text
    select_field.select food.name

    fill_in 'Quantity', with: 10

    click_button 'Add Food'

    expect(page).to have_content('Food was successfully added to the inventory.')
    expect(page).to have_content(food.name)
    expect(page).to have_content(food.measurement_unit)
  end
end
