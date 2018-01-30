class Tag < ApplicationRecord
  belongs_to :user
  belongs_to :taggable, polymorphic: true, optional: true

  has_many :tag_joins
  has_many :bookmarks, through: :tag_joins, source: :taggable, source_type: 'Bookmark'

  validates_presence_of :name, :user_id
end
