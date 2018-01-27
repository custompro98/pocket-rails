require 'rails_helper'

describe 'POST /bookmarks', type: :request do
  before { post api_v1_bookmarks_path, params: attributes }

  context 'when a valid bookmark is submitted' do
    let(:attributes) { {title: 'Test Title', url: 'www.example.com'} }
    let(:status) { :created }

    it_behaves_like 'a successful request'

    it 'includes a location header to redirect to the new bookmark' do
      expect(response.headers['Location']).not_to be_nil
    end
  end

  context 'when an invalid bookmark is submitted' do
    let(:attributes) { {} }
    let(:status) { :unprocessable_entity }

    let(:title_error) { {field: 'title', message: 'can\'t be blank'} }
    let(:url_error) { {field: 'url', message: 'can\'t be blank'} }

    it_behaves_like 'an unsuccessful request'

    it 'returns an unsuccessful message with errors' do
      expect(json[:message]).to eq 'Bookmark cannot be created'
      expect(json[:errors].size).to eq 2
      expect(json[:errors]).to include title_error
      expect(json[:errors]).to include url_error
    end
  end
end
