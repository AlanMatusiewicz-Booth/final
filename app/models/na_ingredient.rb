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

  def summary
    if self.measure == "" || self.measure == nil
      if self.unit == "" || self.unit == nil
        long_name = self.name
      else long_name = self.unit + " " + self.name
      end
    elsif self.unit == "" || self.unit == nil
      long_name = self.measure + " " + self.name
    else
      long_name = self.measure + " " + self.unit + " " + self.name
    end

    return long_name
  end
end
