class AddColumnsToNaIngredients < ActiveRecord::Migration[6.0]
  def change
    add_column :na_ingredients, :unit, :string
    add_column :na_ingredients, :measure, :float
  end
end
