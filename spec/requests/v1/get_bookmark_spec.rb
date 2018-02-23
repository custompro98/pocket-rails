require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Bookmarks::Api

  describe 'GET /bookmarks/:id' do
    include ::Docs::V1::Bookmarks::Show

    let(:owner) { create(:user) }

    before { get v1_bookmark_path(bookmark), headers: headers(owner) }

    context 'when the bookmark exists and is owned by current user' do
      let!(:bookmark) { create(:bookmark, user_id: owner.id) }
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'returns the bookmark', :dox do
        expect(json[:bookmark]).not_to be_empty
        expect(json[:bookmark][:id]).to eq bookmark.id
      end
    end

    context 'when the bookmark exists and is not owned by current user' do
      let!(:bookmark) { create(:bookmark) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'

      it 'returns a not found message', :dox do
        expect(json[:message]).to eq 'Bookmark not found'
      end
    end

    context 'when the bookmark does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'

      it 'returns a not found message', :dox do
        expect(json[:message]).to eq 'Bookmark not found'
      end
    end
  end
end
