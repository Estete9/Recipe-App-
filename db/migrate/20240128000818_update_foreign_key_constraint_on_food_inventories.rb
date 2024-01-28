class UpdateForeignKeyConstraintOnFoodInventories < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :food_inventories, :foods  # Remove the existing foreign key
    add_foreign_key :food_inventories, :foods, on_delete: :cascade  # Add the new foreign key with ON DELETE CASCADE

    remove_foreign_key :recipe_foods, :foods  # Remove the existing foreign key
    add_foreign_key :recipe_foods, :foods, on_delete: :cascade  # Add the new foreign key with ON DELETE CASCADE
  end
end
