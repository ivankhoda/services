class Client < ApplicationRecord
  has_many :orders, dependent: :delete_all
end
