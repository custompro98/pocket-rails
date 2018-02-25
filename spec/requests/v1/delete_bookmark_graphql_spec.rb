require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Graphql::Bookmarks::Api

  describe 'POST /graphql - Bookmark Mutation Delete', type: :request do
    include ::Docs::V1::Graphql::Bookmarks::Destroy

    let(:owner) { create(:user) }
    let(:query) do
      { "query":
          "mutation deleteBookmark{
            deleteBookmark(input: { id: #{bookmark.id} })
            { bookmark { id } }
          }" }
    end

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'the bookmark to delete exists and is owned by current user' do
      let(:bookmark) { create(:bookmark, user_id: owner.id) }

      it_behaves_like 'a successful request'

      it 'deletes the bookmark', :dox do
        expect{ ::Bookmark.find(bookmark.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'the bookmark to delete exists and is not owned by current user' do
      let(:bookmark) { create(:bookmark) }

      it_behaves_like 'a successful request'

      it 'does not delete the bookmark' do
        expect(::Bookmark.find(bookmark.id)).to eq bookmark
      end

      it 'returns an error message', :dox do
        expect(json[:error]).to eq 'Bookmark not found'
      end
    end

    context 'the bookmark to delete does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }

      it_behaves_like 'a successful request'

      it 'returns an error message' do
        expect(json[:error]).to eq 'Bookmark not found'
      end
    end
  end
end
