require 'rails_helper'

describe 'DELETE /bookmarks/:bookmark_id/tags/:id', type: :request do
  let(:owner) { create(:user) }
  let(:bookmark) { create(:bookmark, user_id: owner.id) }

  before { delete v1_bookmark_tag_path(bookmark, tag), headers: headers(owner) }

  context 'the tag to delete exists' do
    let(:tag) { create(:tag, user_id: owner.id, taggable: bookmark) }
    let(:status) { :no_content }

    it_behaves_like 'a successful request'

    it 'deletes the tag from the bookmark, but not the tag itself' do
      expect(::Tag.find(tag.id).id).to eq tag.id
      expect(::Bookmark.find(bookmark.id).tags).to be_empty
    end
  end

  context 'the tag to delete is not attached to the bookmark' do
    let(:tag) { create(:tag, user_id: owner.id) }
    let(:status) { :not_found }

    it_behaves_like 'an unsuccessful request'

    it 'doesn\'t delete the tag' do
      expect(::Tag.find(tag.id).id).to eq tag.id
    end
  end
end
