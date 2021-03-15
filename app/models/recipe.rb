# == Schema Information
#
# Table name: recipes
#
#  id          :integer          not null, primary key
#  iba_status  :boolean
#  name        :string
#  preparation :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  user_id     :integer
#
class Recipe < ApplicationRecord
  # Direct Associations
  belongs_to(:user, { :required => true })
  has_many(:ingredients, { :dependent => :destroy })
  has_many(:saved_recipes, { :dependent => :destroy })
  has_many(:na_ingredients, { :dependent => :destroy })

  # Indirect Associations
  has_many(:users, { :through => :saved_recipes, :source => :user })
  has_many(:alcohols, { :through => :ingredients, :source => :alcohol })

  # Validations
  validates(:name, { :presence => true })
  validates(:iba_status, { :default => false })

  # Additional Methods
  def ingredient_list
    list = Array.new
      self.ingredients.order({ :measure_ml => :desc }).each do |a_ingredient|
        list.push(a_ingredient.alcohol.name)
      end
      self.na_ingredients.order({ :name => :asc }).each do |a_na_ingredient|
        list.push(a_na_ingredient.name)
      end
    
    return list    
  end
end
