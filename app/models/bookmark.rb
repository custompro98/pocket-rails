class Bookmark < ApplicationRecord
  validates_presence_of :title, :url, :user_id

  belongs_to :user

  has_many :tag_joins, as: :taggable
  has_many :tags, through: :tag_joins
end
