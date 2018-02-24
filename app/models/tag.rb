class Tag < ApplicationRecord
  belongs_to :user
  belongs_to :taggable, polymorphic: true, optional: true

  has_many :tag_joins, dependent: :destroy
  has_many :bookmarks, through: :tag_joins, source: :taggable, source_type: 'Bookmark'

  validates_presence_of :name, :user_id
  validates_uniqueness_of :name, scope: [:user_id, :archived]

  def self.owned_by(current_user)
    where(user_id: current_user.id)
  end
end
