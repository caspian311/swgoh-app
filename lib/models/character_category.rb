class CharacterCategory < ActiveRecord::Base
  belongs_to :character
  belongs_to :category
end
