require 'rails_helper'

describe 'Bookmark Tags', type: :request do
  include ::Docs::V1::BookmarkTags::Api

  describe 'DELETE /bookmarks/:bookmark_id/tags/:id' do
    include ::Docs::V1::BookmarkTags::Destroy

    let(:owner) { create(:user) }
    let(:bookmark) { create(:bookmark, user_id: owner.id) }

    before { delete v1_bookmark_tag_path(bookmark, tag), headers: headers(owner) }

    context 'the tag to delete exists' do
      let(:tag) { create(:tag, user_id: owner.id, taggable: bookmark) }
      let(:status) { :no_content }

      it_behaves_like 'a successful request'

      it 'deletes the tag from the bookmark, but not the tag itself', :dox do
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

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Tag not found'
      end
    end

    context 'the tag to delete is not owned by the current user' do
      let(:tag) { create(:tag, taggable: bookmark) }
      let(:status) { :forbidden }

      it_behaves_like 'an unsuccessful request'

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Tag is owned by a different user'
      end
    end

    context 'the bookmark to delete is not owned by the current user' do
      let(:bookmark) { create(:bookmark) }
      let(:tag) { create(:tag, user_id: owner.id, taggable: bookmark) }

      it_behaves_like 'a successful request'

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Bookmark is owned by a different user'
      end
    end
  end
end
