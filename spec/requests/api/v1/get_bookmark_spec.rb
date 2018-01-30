require 'rails_helper'

describe 'GET /bookmarks/:id', type: :request do
  let(:owner) { create(:user) }

  before { get api_v1_bookmark_path(bookmark), headers: headers(owner) }

  context 'when the bookmark exists and is owned by current user' do
    let!(:bookmark) { create(:bookmark, user_id: owner.id) }
    let(:status) { :ok }

    it_behaves_like 'a successful request'

    it 'returns the todo' do
      expect(json).not_to be_empty
      expect(json[:id]).to eq bookmark.id
    end
  end

  context 'when the bookmark exists and is not owned by current user' do
    let!(:bookmark) { create(:bookmark) }
    let(:status) { :not_found }

    it_behaves_like 'an unsuccessful request'

    it 'returns a not found message' do
      expect(json[:message]).to eq 'Bookmark not found'
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
