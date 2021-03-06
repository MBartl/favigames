class User < ApplicationRecord
  has_secure_password

  has_many :favorites
  has_many :games, through: :favorites

  validates :name, uniqueness: true

end
