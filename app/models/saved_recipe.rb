# == Schema Information
#
# Table name: saved_recipes
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  recipe_id  :integer
#  user_id    :integer
#
class SavedRecipe < ApplicationRecord
  # Direct Associations
  belongs_to(:user, { :required => true })
  belongs_to(:recipe, { :required => true })

  # Indirect Associations

  
  # Validations


  # Additional Methods
end
