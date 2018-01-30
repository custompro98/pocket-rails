class BookmarkSerializer < ActiveModel::Serializer
  attributes :id, :title, :url

  has_many :tags
end
