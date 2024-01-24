class AddQuantityToFood < ActiveRecord::Migration[7.1]
  def change
    add_column :foods, :quantity, :integer
  end
end
