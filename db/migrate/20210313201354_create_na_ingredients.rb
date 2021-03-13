class CreateNaIngredients < ActiveRecord::Migration[6.0]
  def change
    create_table :na_ingredients do |t|
      t.integer :recipe_id
      t.string :name

      t.timestamps
    end
  end
end
