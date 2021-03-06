require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Graphql::Bookmarks::Api

  describe 'POST /graphql - Bookmarks Mutation' do
    include ::Docs::V1::Graphql::Bookmarks::Create

    let(:owner) { create(:user) }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'when a valid bookmark is submitted' do
      let(:query) do
        { "query":
            "mutation createBookmark{
              createBookmark(input: { title: \"GraphQL\",
                                      url: \"http://www.graphql.org\",
                                      favorite: false,
                                      archived: false })
              { bookmark { id } }
            }" }
      end
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'includes selected fields from the bookmark' do
        expect(json[:data][:createBookmark][:bookmark][:id]).not_to be_nil
      end

      it 'creates a bookmark owned by current user', :dox do
        expect(::Bookmark.first.user_id).to eq(owner.id)
      end
    end

    context 'when an invalid bookmark is submitted' do
      let(:query) do
        { "query":
            "mutation createBookmark{
              createBookmark(input: { favorite: false,
                                      archived: false })
              { bookmark { id } }
            }" }
      end
      let(:status) { :ok }

      let(:title_error) { {field: 'title', message: 'can\'t be blank'} }
      let(:url_error) { {field: 'url', message: 'can\'t be blank'} }

      it_behaves_like 'a successful request'

      it 'returns an unsuccessful message with errors', :dox do
        expect(json[:data][:message]).to eq 'Graphql cannot be executed'
        expect(json[:data][:errors].size).to eq 2
        expect(json[:data][:errors]).to include title_error
        expect(json[:data][:errors]).to include url_error
      end
    end
  end
end
