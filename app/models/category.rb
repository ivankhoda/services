class Category < ApplicationRecord
  has_many :services
  # has_many :orders, through: :services
end
