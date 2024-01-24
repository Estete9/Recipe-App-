class RemoveUserFromRecipes < ActiveRecord::Migration[7.1]
  def change
    remove_column :recipes, :user
  end
end
