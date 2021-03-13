# == Schema Information
#
# Table name: alcohols
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Alcohol < ApplicationRecord
  # Direct Associations
  has_many(:bottles, { :dependent => :destroy })
  has_many(:ingredients, { :dependent => :destroy })

  # Indirect Associations
  has_many(:users, { :through => :bottles, :source => :user })
  has_many(:recipes, { :through => :ingredients, :source => :recipe })

  # Validations
  validates(:name, { :presence => true })

  # Additional Methods
end
