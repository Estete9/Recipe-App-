class ChangeQuantityToNotNullInFoodInventories < ActiveRecord::Migration[7.1]
  def change
     change_column :food_inventories, :quantity, :integer, null: false
  end
end
