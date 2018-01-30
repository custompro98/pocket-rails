require 'rails_helper'

describe ::TagJoin, type: :model do
  describe 'validations' do
    subject { ::TagJoin.create(tag_id: 1, taggable_id: 1, taggable_type: 'Bookmark') }
    it { should validate_uniqueness_of(:taggable_id).scoped_to [:taggable_type, :tag_id] }
  end

  describe 'assocations' do
    it { should belong_to(:tag) }
    it { should belong_to(:taggable) }
  end
end
