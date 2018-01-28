require 'rails_helper'

describe 'DELETE /bookmarks/:id', type: :request do
  before { delete api_v1_bookmark_path(bookmark.id), headers: headers }

  context 'the bookmark to delete exists' do
    let(:bookmark) { create(:bookmark) }
    let(:status) { :no_content }

    it_behaves_like 'a successful request'

    it 'deletes the bookmark' do
      expect{ ::Bookmark.find(bookmark.id) }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  context 'the bookmark to delete does not exist' do
    let(:bookmark) { OpenStruct.new(id: 1) }
    let(:status) { :not_found }

    it_behaves_like 'an unsuccessful request'
  end
end
