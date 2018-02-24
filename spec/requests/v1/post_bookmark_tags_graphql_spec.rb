require 'rails_helper'

describe 'Bookmark Tags', type: :request do
  describe 'POST /graphql - Bookmark Tags Mutation' do
    let(:owner) { create(:user) }
    let(:bookmark) { create(:bookmark, user_id: owner.id) }
    let(:query) do
      { "query":
          "mutation addTag{
            addTag(input: { bookmarkId: #{bookmark.id}, tagIds: #{tag_ids} })
            { bookmark { id } }
          }" }
    end
    let(:status) { :ok }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'when the bookmark doesn\'t exist and tag doesn\'t exist' do
      let(:bookmark) { OpenStruct.new(id: 1) }
      let(:tag_ids) { [1] }
      let(:status) { :ok }

      let(:tag_error) { {field: 'tag', message: 'must exist'} }
      let(:taggable_error) { {field: 'taggable', message: 'must exist'} }

      it_behaves_like 'a successful request'

      it 'returns an unsuccessful message with errors' do
        expect(json[:message]).to eq 'Graphql cannot be executed'
        expect(json[:errors].size).to eq 2
        expect(json[:errors]).to include tag_error
        expect(json[:errors]).to include taggable_error
      end
    end

    context 'when a single tag is added' do
      let(:tag_ids) { [create(:tag, user_id: owner.id).id] }

      it_behaves_like 'a successful request'

      it 'attaches the tag to the bookmark' do
        expect(::Bookmark.find(bookmark.id).tags.first.id).to eq(tag_ids.first)
      end

      it 'includes selected fields from the bookmark' do
        expect(json[:addTag][:bookmark][:id]).not_to be_nil
      end
    end

    context 'when many tags are added' do
      let(:tag_ids) { create_list(:tag, 2, user_id: owner.id).map(&:id) }

      it_behaves_like 'a successful request'

      it 'attaches many tags to the bookmark' do
        expect(::Bookmark.find(bookmark.id).tags.map(&:id).sort).to eq(tag_ids.sort)
      end
    end

    context 'when the tag being added is already attached' do
      let(:tag_ids) { [create(:tag, user_id: owner.id, taggable: bookmark).id] }

      let(:taggable_error) { {field: 'taggable_id', message: 'has already been taken'} }

      it_behaves_like 'a successful request'

      it 'returns an unsuccessful message with errors' do
        expect(json[:message]).to eq 'Graphql cannot be executed'
        expect(json[:errors].size).to eq 1
        expect(json[:errors]).to include taggable_error
      end
    end

    context 'when the tag being added is not owned by the current user' do
      let(:tag_ids) { [create(:tag, taggable: bookmark).id] }

      it_behaves_like 'a successful request'

      it 'returns an unsuccessful message' do
        expect(json[:error]).to eq 'Tag is owned by a different user'
      end
    end
  end
end
