class AddUserToRecipes < ActiveRecord::Migration[7.1]
  def change
    add_reference :recipes, :user, foreign_key: true
  end
end
