require 'rails_helper'

describe ::Bookmark, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title)  }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'assocations' do
    it { should belong_to(:user) }
    it { should have_many(:tag_joins) }
    it { should have_many(:tags) }
  end
end
