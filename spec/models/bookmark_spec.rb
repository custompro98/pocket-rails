require 'rails_helper'

describe ::Bookmark, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:title)  }
    it { should validate_presence_of(:url) }
    it { should validate_presence_of(:user_id) }
  end

  describe 'assocations' do
    it { should belong_to(:user) }
    it { should have_many(:tag_joins).dependent(:destroy) }
    it { should have_many(:tags) }
  end

  describe '#with_tag' do
    let(:subject) { described_class }

    let(:owner) { create(:user) }
    let!(:bookmark_with_tag) { create(:bookmark, user_id: owner.id) }
    let!(:bookmark_without_tag) { create(:bookmark, user_id: owner.id) }
    let!(:tag) { create(:tag, user_id: owner.id, taggable: bookmark_with_tag) }

    it 'narrows down bookmarks by tag' do
      expect(subject.with_tag(tag.id).count).to eq(1)
    end
  end
end
