class CreateRecipes < ActiveRecord::Migration[7.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.datetime :preparation_time
      t.datetime :cooking_time
      t.text :description
      t.boolean :public
      t.integer :user, foreign_key: true

      t.timestamps
    end
  end
end
