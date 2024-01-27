class ChangeNameToNotNullInInventories < ActiveRecord::Migration[7.1]
  def change
    change_column :inventories, :name, :string, null: false
  end
end
