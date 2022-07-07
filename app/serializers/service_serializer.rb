class ServiceSerializer
  include JSONAPI::Serializer
  attributes :title, :category, :category_id
end
