class Bookmark < ApplicationRecord
  extend Authenticatable

  validates_presence_of :title, :url, :user_id

  belongs_to :user

  has_many :tag_joins, as: :taggable, dependent: :destroy
  has_many :tags, through: :tag_joins

  def self.owned_by(user)
    where(user_id: user.id)
  end

  def self.with_tag(tag)
    joins(:tags).where(tags: {id: tag})
  end
end
