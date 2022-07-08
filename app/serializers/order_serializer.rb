class OrderSerializer
  include JSONAPI::Serializer
  attributes :client_name, :position, :assignee_name, :price, :client_id, :assignee_id, :service_id
  has_many :positions
end
