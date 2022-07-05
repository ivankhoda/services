class OrderSerializer
  include JSONAPI::Serializer
  attributes :client, :services, :assignee, :price
end
