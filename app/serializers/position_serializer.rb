class PositionSerializer
  include JSONAPI::Serializer
  attributes :title, :category, :category_id, :id
end
