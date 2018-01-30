class TagSerializer < ActiveModel::Serializer
  attributes :id, :name, :favorite, :archived
end
