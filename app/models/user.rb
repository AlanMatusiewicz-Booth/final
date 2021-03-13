# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string
#  password_digest :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  validates :email, :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true
  has_secure_password

  # Direct Associations
  has_many(:bottles, { :dependent => :destroy })
  has_many(:recipes)
  has_many(:saved_recipes, { :dependent => :destroy })

  # Indirect Associations
  has_many(:favorites, { :through => :saved_recipes, :source => :recipe })
  has_many(:bar, { :through => :bottles, :source => :alcohol })

  # Validations


  # Additional Methods
end
