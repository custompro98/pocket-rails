require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Bookmarks::Api

  describe 'DELETE /bookmarks/:id', type: :request do
    include ::Docs::V1::Bookmarks::Destroy

    let(:owner) { create(:user) }

    before { delete v1_bookmark_path(bookmark), headers: headers(owner) }

    context 'the bookmark to delete exists and is owned by current user' do
      let(:bookmark) { create(:bookmark, user_id: owner.id) }
      let(:status) { :no_content }

      it_behaves_like 'a successful request'

      it 'deletes the bookmark', :dox do
        expect{ ::Bookmark.find(bookmark.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'the bookmark to delete exists and is not owned by current user' do
      let(:bookmark) { create(:bookmark) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'
    end

    context 'the bookmark to delete does not exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Bookmark not found'
      end
    end
  end
end
