class OrderSerializer
  include JSONAPI::Serializer
  attributes :client_name, :assignee_name, :price, :client_id, :assignee_id, :services, :positions
end
