class RemoveForeignKeyAndAddCascadeToRecipeFoods < ActiveRecord::Migration[7.1]
  def up
    remove_foreign_key :recipe_foods, :recipes
    add_foreign_key :recipe_foods, :recipes, on_delete: :cascade
  end
end
