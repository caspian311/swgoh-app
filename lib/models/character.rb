class Character < ActiveRecord::Base
  has_many :character_categories
  has_many :categories, through: :character_categories
end
