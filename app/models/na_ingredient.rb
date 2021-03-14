# == Schema Information
#
# Table name: na_ingredients
#
#  id         :integer          not null, primary key
#  measure    :string
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
  def NaIngredient.summary
    if NaIngredient.measure == nil && NaIngredient.unit == nil
      long_name = NaIngredient.name
    elsif NaIngredient.measure == nil
      long_name = NaIngredient.unit + " " + NaIngredient.name
    elsif NaIngredient.unit == nil
      long_name = NaIngredient.measure + " " + NaIngredient.name
    else
      long_name = NaIngredient.measure + " " + NaIngredient.unit + " " + NaIngredient.name
    end

    return long_name
  end
end
