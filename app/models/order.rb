class Order < ApplicationRecord
  belongs_to :client
  belongs_to :assignee
  has_many :services
  serialize :services, Array
end
