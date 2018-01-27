class Bookmark < ApplicationRecord
  validates_presence_of :title, :url, :user_id

  belongs_to :user
end
