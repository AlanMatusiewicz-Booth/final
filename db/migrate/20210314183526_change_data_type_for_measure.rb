class ChangeDataTypeForMeasure < ActiveRecord::Migration[6.0]
    def up
        change_column :na_ingredients, :measure, :string
    end

    def down
        change_column :na_ingredients, :measure, :float
    end
end
