require 'rails_helper'

describe 'GET /bookmarks/:bookmark_id/tags', type: :request do
  let(:owner) { create(:user) }
  let(:bookmark) { create(:bookmark, user_id: owner.id) }
  let(:status) { :ok }

  context 'there are no tags attached to the bookmark' do
    before { get api_v1_bookmark_tags_path(bookmark), headers: headers(owner) }

    it_behaves_like 'a successful request'

    it 'returns an empty array' do
      expect(json).to be_empty
    end
  end

  context 'there are fewer than the page limit tags attached to the bookmark' do
    let!(:tags) { create_list(:tag, 9, user_id: owner.id, taggable: bookmark) }

    before { get api_v1_bookmark_tags_path(bookmark), headers: headers(owner) }

    it_behaves_like 'a successful request'

    it 'returns all tags attached to the bookmark' do
      expect(json).not_to be_empty
      expect(json.size).to eq 9
    end
  end

  context 'there are more than the page limit tags attached to the bookmark' do
    let!(:tags) { create_list(:tag, 19, user_id: owner.id, taggable: bookmark) }
    let(:params) { {} }

    before { get api_v1_bookmark_tags_path(bookmark), params: params, headers: headers(owner) }

    context 'page 1' do
      it 'returns the first 10 tags' do
        expect(json).not_to be_empty
        expect(json.size).to eq 10
      end
    end

    context 'page 2' do
      let(:params) { {page: 2} }

      it 'returns the next 9 tags' do
        expect(json).not_to be_empty
        expect(json.size).to eq 9
      end
    end
  end
end
