require 'rails_helper'

describe 'DELETE /bookmarks/:id', type: :request do
  let(:owner) { create(:user) }

  before { delete api_v1_bookmark_path(bookmark), headers: headers(owner) }

  context 'the bookmark to delete exists and is owned by current user' do
    let(:bookmark) { create(:bookmark, user_id: owner.id) }
    let(:status) { :no_content }

    it_behaves_like 'a successful request'

    it 'deletes the bookmark' do
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
  end
end
