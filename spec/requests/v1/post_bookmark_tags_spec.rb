require 'rails_helper'

describe 'Bookmark Tags', type: :request do
  include ::Docs::V1::BookmarkTags::Api

  describe 'POST /bookmarks/:bookmark_id/tags' do
    include ::Docs::V1::BookmarkTags::Create

    let(:owner) { create(:user) }
    let(:bookmark) { create(:bookmark, user_id: owner.id) }
    let(:status) { :created }

    before { post v1_bookmark_tags_path(bookmark), params: {tag_ids: tag_ids}.to_json, headers: headers(owner) }

    context 'when the bookmark doesn\'t exist and tag doesn\'t exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:tag_ids) { [1] }
      let(:status) { :unprocessable_entity }

      let(:tag_error) { {field: 'tag', message: 'must exist'} }
      let(:taggable_error) { {field: 'taggable', message: 'must exist'} }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unsuccessful message with errors', :dox do
        expect(json[:message]).to eq 'Tag cannot be created'
        expect(json[:errors].size).to eq 2
        expect(json[:errors]).to include tag_error
        expect(json[:errors]).to include taggable_error
      end
    end

    context 'when a single tag is added' do
      let(:tag_ids) { [create(:tag, user_id: owner.id).id] }

      it_behaves_like 'a successful request'

      it 'attaches the tag to the bookmark', :dox do
        expect(::Bookmark.find(bookmark.id).tags.first.id).to eq(tag_ids.first)
      end

      it 'includes a location header to redirect to the bookmark' do
        expect(response.headers['Location']).not_to be_nil
        expect(response.headers['Location']).to eq v1_bookmark_path(bookmark)
      end
    end

    context 'when many tags are added' do
      let(:tag_ids) { create_list(:tag, 2, user_id: owner.id).map(&:id) }

      it_behaves_like 'a successful request'

      it 'attaches many tags to the bookmark', :dox do
        expect(::Bookmark.find(bookmark.id).tags.map(&:id).sort).to eq(tag_ids.sort)
      end
    end

    context 'when the tag being added is already attached' do
      let(:status) { :unprocessable_entity }
      let(:tag_ids) { [create(:tag, user_id: owner.id, taggable: bookmark).id] }

      let(:taggable_error) { {field: 'taggable_id', message: 'has already been taken'} }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unsuccessful message with errors', :dox do
        expect(json[:message]).to eq 'Tag cannot be created'
        expect(json[:errors].size).to eq 1
        expect(json[:errors]).to include taggable_error
      end
    end

    context 'when the tag being added is not owned by the current user' do
      let(:tag_ids) { [create(:tag, taggable: bookmark).id] }
      let(:status) { :forbidden }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unsuccessful message', :dox do
        expect(json[:message]).to eq 'Tag is owned by a different user'
      end
    end
  end
end
