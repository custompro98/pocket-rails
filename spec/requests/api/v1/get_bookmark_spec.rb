require 'rails_helper'

describe 'GET /bookmarks/:id', type: :request do
  before { get api_v1_bookmark_path(bookmark.id) }

  context 'when the bookmark exists' do
    let!(:bookmark) { create(:bookmark) }
    let(:status) { :ok }

    it_behaves_like 'a successful request'

    it 'returns the todo' do
      expect(json).not_to be_empty
      expect(json[:id]).to eq bookmark.id
    end
  end

  context 'when the bookmark does not exist' do
    let(:bookmark) { OpenStruct.new(id: 1) }
    let(:status) { :not_found }

    it_behaves_like 'an unsuccessful request'

    it 'returns a not found message' do
      expect(json[:message]).to eq 'Bookmark not found'
    end
  end
end
