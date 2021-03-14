# == Schema Information
#
# Table name: ingredients
#
#  id         :integer          not null, primary key
#  measure    :float
#  measure_ml :float
#  unit       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  alcohol_id :integer
#  recipe_id  :integer
#
class Ingredient < ApplicationRecord
  # Direct Associations
  belongs_to(:recipe, { :required => true })
  belongs_to(:alcohol, { :required => true })

  # Indirect Associations


  # Validations
  validates(:measure, { :numericality => { :greater_than => 0 } })
  validates(:measure, { :presence => true })
  validates(:measure_ml, { :numericality => { :greater_than => 0 } })
  validates(:measure_ml, { :presence => true })
  validates(:alcohol_id, { :uniqueness => { :scope => ["recipe_id"], :message => "has already been added to recipe" } })

  # Additional Methods
end
