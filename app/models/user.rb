class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates_uniqueness_of :email, case_sensitive: true, scope: :provider
  validates_presence_of :first_name, :last_name, :email

  has_many :bookmarks, dependent: :destroy
end
