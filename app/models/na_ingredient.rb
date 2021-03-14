# == Schema Information
#
# Table name: na_ingredients
#
#  id         :integer          not null, primary key
#  measure    :float
#  name       :string
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#
class NaIngredient < ApplicationRecord
  # Direct Associations
  belongs_to(:recipe, { :required => true })

  # Indirect Associations


  # Validations
  validates(:name, { :presence => true })
  validates(:name, { :uniqueness => { :scope => ["recipe_id"], :message => "has already been added to recipe" } })

  # Additional Methods
end
