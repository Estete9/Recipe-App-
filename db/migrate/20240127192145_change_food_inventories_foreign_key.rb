class ChangeFoodInventoriesForeignKey < ActiveRecord::Migration[7.1]
  def change
    remove_foreign_key :inventories, :users
    add_foreign_key :inventories, :users, on_delete: :nullify

    remove_foreign_key :food_inventories, :inventories
    add_foreign_key :food_inventories, :inventories, on_delete: :cascade
  end
end
