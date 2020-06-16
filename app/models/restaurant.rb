class Restaurant < ApplicationRecord
  STRONG_PARAMS = %i[
    name
    address
  ]

  has_many :reviews
  has_many :restaurant_tags
  has_many :tags, through: :restaurant_tags

end
