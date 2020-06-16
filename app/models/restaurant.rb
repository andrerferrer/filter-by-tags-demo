class Restaurant < ApplicationRecord
  STRONG_PARAMS = %i[
    name
    address
  ]

  has_many :reviews
  has_many :restaurants_tags
  has_many :tags, through: :restaurants_tags

end
