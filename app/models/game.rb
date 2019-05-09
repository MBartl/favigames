class Game < ApplicationRecord
  has_many :favorites
  has_many :users, through: :favorites

  self.per_page = 10

end
