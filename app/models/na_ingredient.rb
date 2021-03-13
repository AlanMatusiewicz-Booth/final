# == Schema Information
#
# Table name: na_ingredients
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#
class NaIngredient < ApplicationRecord
end
