require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Graphql::Bookmarks::Api

  describe 'POST /graphql - Bookmark' do
    include ::Docs::V1::Graphql::Bookmarks::Show

    let(:owner) { create(:user) }
    let(:query) { { query: "{me {bookmark(id: #{bookmark.id}) {id}}}"} }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'when the bookmark exists and is owned by current user' do
      let!(:bookmark) { create(:bookmark, user_id: owner.id) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns the bookmark', :dox do
        expect(json[:data][:me][:bookmark]).not_to be_empty
        expect(json[:data][:me][:bookmark][:id]).to eq bookmark.id.to_s
      end
    end

    context 'when the bookmark exists and is not owned by current user' do
      let!(:bookmark) { create(:bookmark) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns a not found message', :dox do
        expect(json[:data][:error]).to eq 'Bookmark not found'
      end
    end

    context 'when the bookmark does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns a not found message', :dox do
        expect(json[:data][:error]).to eq 'Bookmark not found'
      end
    end
  end
end
