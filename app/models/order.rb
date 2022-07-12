class Order < ApplicationRecord
  belongs_to :client
  belongs_to :assignee
  has_many :services, dependent: :delete_all
  serialize :positions, array: true, default: []
end
