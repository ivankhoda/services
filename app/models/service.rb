class Service < ApplicationRecord
  belongs_to :category
  belongs_to :order, optional: true
end
