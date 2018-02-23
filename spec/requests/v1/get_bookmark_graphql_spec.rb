require 'rails_helper'

describe 'Bookmarks', type: :request do
  describe 'POST /graphql - Bookmark' do
    let(:owner) { create(:user) }
    let(:query) { { query: "{bookmark(id: #{bookmark.id}) {id}}"} }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'when the bookmark exists and is owned by current user' do
      let!(:bookmark) { create(:bookmark, user_id: owner.id) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns the bookmark' do
        expect(json[:bookmark]).not_to be_empty
        expect(json[:bookmark][:id]).to eq bookmark.id
      end
    end

    context 'when the bookmark exists and is not owned by current user' do
      let!(:bookmark) { create(:bookmark) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns a not found message' do
        expect(json[:error]).to eq 'Bookmark not found'
      end
    end

    context 'when the bookmark does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns a not found message' do
        expect(json[:error]).to eq 'Bookmark not found'
      end
    end
  end
end
