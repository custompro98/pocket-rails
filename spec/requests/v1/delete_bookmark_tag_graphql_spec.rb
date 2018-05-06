require 'rails_helper'

describe 'Bookmark Tags', type: :request do
  include ::Docs::V1::Graphql::BookmarkTags::Api

  describe 'POST /graphql - Bookmark Tag Mutation Delete' do
    include ::Docs::V1::Graphql::BookmarkTags::Destroy

    let(:owner) { create(:user) }
    let(:bookmark) { create(:bookmark, user_id: owner.id) }
    let(:query) do
      { "query":
          "mutation removeTag{
            removeTag(input: { bookmarkId: #{bookmark.id}, tagId: #{tag.id} })
            { bookmark { id } }
          }" }
    end

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'the tag to delete exists' do
      let(:tag) { create(:tag, user_id: owner.id, taggable: bookmark) }

      it_behaves_like 'a successful request'

      it 'deletes the tag from the bookmark, but not the tag itself', :dox do
        expect(::Tag.find(tag.id).id).to eq tag.id
        expect(::Bookmark.find(bookmark.id).tags).to be_empty
      end
    end

    context 'the tag to delete is not attached to the bookmark' do
      let(:tag) { create(:tag, user_id: owner.id) }

      it_behaves_like 'a successful request'

      it 'doesn\'t delete the tag' do
        expect(::Tag.find(tag.id).id).to eq tag.id
      end

      it 'returns an error message', :dox do
        expect(json[:data][:error]).to eq 'Tag not found'
      end
    end

    context 'the tag to delete is not owned by the current user' do
      let(:tag) { create(:tag, taggable: bookmark) }

      it_behaves_like 'a successful request'

      it 'returns an error message', :dox do
        expect(json[:data][:error]).to eq 'Tag is owned by a different user'
      end
    end

    context 'the bookmark to delete is not owned by the current user' do
      let(:bookmark) { create(:bookmark) }
      let(:tag) { create(:tag, user_id: owner.id, taggable: bookmark) }

      it_behaves_like 'a successful request'

      it 'returns an error message', :dox do
        expect(json[:data][:error]).to eq 'Bookmark is owned by a different user'
      end
    end
  end
end
