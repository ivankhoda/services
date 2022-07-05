class ClientSerializer
  include JSONAPI::Serializer
  attributes :name, :surname
end
