class OrderSerializer
  include JSONAPI::Serializer
  attributes :client_name, :positions, :assignee_name, :price, :client_id, :assignee_id
  has_many :positions
end
