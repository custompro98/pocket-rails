require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Graphql::Bookmarks::Api

  describe 'POST /graphql - Bookmark Mutation', type: :request do
    include ::Docs::V1::Graphql::Bookmarks::Update

    let(:owner) { create(:user) }
    let(:status) { :ok }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'the bookmark to update already exists and is owned by current user' do
      let(:bookmark) { create(:bookmark, user_id: owner.id) }

      context 'when all bookmark attributes are submitted' do
        let(:query) do
          { "query":
              "mutation updateBookmark{
                updateBookmark(input: { id: #{bookmark.id}
                                        title: \"GraphQL\",
                                        url: \"http://www.graphql.org\",
                                        favorite: false,
                                        archived: false })
                { bookmark { id } }
              }" }
        end

        it_behaves_like 'a successful request'

        it 'includes selected fields from the bookmark', :dox do
          expect(json[:data][:updateBookmark][:bookmark][:id]).not_to be_nil
        end
      end

      context 'when not all bookmark attributes are submitted' do
        let(:query) do
          { "query":
              "mutation updateBookmark{
                updateBookmark(input: { id: #{bookmark.id}
                                        title: \"GraphQL\" })
                { bookmark { id } }
              }" }
        end

        let(:url_error) { {field: 'url', message: 'can\'t be blank'} }

        it_behaves_like 'a successful request'

        it 'includes selected fields from the bookmark' do
          expect(json[:data][:updateBookmark][:bookmark][:id]).not_to be_nil
        end
      end
    end

    context 'the bookmark to update already exists and is not owned by current user' do
      let(:bookmark) { create(:bookmark) }

      context 'when all required bookmark attributes are submitted' do
        let(:query) do
          { "query":
              "mutation updateBookmark{
                updateBookmark(input: { id: #{bookmark.id}
                                        title: \"GraphQL\",
                                        url: \"http://www.graphql.org\",
                                        favorite: false,
                                        archived: false })
                { bookmark { id } }
              }" }
        end

        it_behaves_like 'a successful request'

        it 'does not update the bookmark' do
          expect(::Bookmark.first.title).not_to eq 'Test Title'
        end

        it 'returns an unsuccessful message', :dox do
          expect(json[:data][:error]).to eq 'Bookmark is owned by a different user'
        end
      end
    end

    context 'the bookmark to update does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }

      context 'when all required bookmark attributes are submitted' do
        let(:query) do
          { "query":
              "mutation updateBookmark{
                updateBookmark(input: { id: #{bookmark.id}
                                        title: \"GraphQL\",
                                        url: \"http://www.graphql.org\",
                                        favorite: false,
                                        archived: false })
                { bookmark { id } }
              }" }
        end
        let(:status) {:ok}

        it_behaves_like 'a successful request'

        it 'includes selected fields from the bookmark' do
          expect(json[:data][:updateBookmark][:bookmark][:id]).not_to be_nil
        end
      end
    end
  end
end
