require 'rails_helper'

describe 'PUT /bookmarks/:id', type: :request do
  let(:owner) { create(:user) }

  before { put api_v1_bookmark_path(bookmark), params: attributes, headers: headers(owner) }

  context 'the bookmark to update already exists and is owned by current user' do
    let(:bookmark) { create(:bookmark, user_id: owner.id) }

    context 'when all required bookmark attributes are submitted' do
      let(:attributes) do
        {title: 'Test Title', url: 'www.example.com', archived: true, favorite: true}
      end
      let(:status) { :no_content }

      it_behaves_like 'a successful request'

      it 'includes a location header to redirect to the bookmark' do
        expect(response.headers['Location']).not_to be_nil
      end
    end

    context 'when not all required bookmark attributes are submitted' do
      let(:attributes) { {title: 'Test Title'} }
      let(:status) { :unprocessable_entity }

      let(:url_error) { {field: 'url', message: 'can\'t be blank'} }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unscucessful message with errors' do
        expect(json[:message]).to eq 'Bookmark cannot be updated'
        expect(json[:errors].size).to eq 1
        expect(json[:errors]).to include url_error
      end
    end
  end

  context 'the bookmark to update already exists and is not owned by current user' do
    let(:bookmark) { create(:bookmark) }

    context 'when all required bookmark attributes are submitted' do
      let(:attributes) do
        {title: 'Test Title', url: 'www.example.com', archived: true, favorite: true}
      end
      let(:status) { :forbidden }

      it_behaves_like 'an unsuccessful request'

      it 'does not update the bookmark' do
        expect(::Bookmark.first.title).not_to eq 'Test Title'
      end

      it 'returns an unsuccessful message' do
        expect(json[:message]).to eq 'Bookmark is owned by a different user'
      end
    end

    context 'when not all required bookmark attributes are submitted' do
      let(:attributes) { {title: 'Test Title'} }
      let(:status) { :forbidden }

      let(:url_error) { {field: 'url', message: 'can\'t be blank'} }

      it_behaves_like 'an unsuccessful request'

      it 'does not update the bookmark' do
        expect(::Bookmark.first.title).not_to eq 'Test Title'
      end

      it 'returns an unsuccessful message' do
        expect(json[:message]).to eq 'Bookmark is owned by a different user'
      end
    end
  end

  context 'the bookmark to update does not exist' do
    let(:bookmark) { OpenStruct.new(id: 1) }

    context 'when all required bookmark attributes are submitted' do
      let(:attributes) do
        {title: 'Test Title', url: 'www.example.com', archived: true, favorite: true}
      end
      let(:status) {:created}

      it_behaves_like 'a successful request'

      it 'includes a location header to redirect to the bookmark' do
        expect(response.headers['Location']).not_to be_nil
      end
    end
  end
end
