require 'rails_helper'

describe 'Tags', type: :request do
  include ::Docs::V1::Graphql::Tags::Api

  describe 'POST /graphql - Tag Mutation Delete', type: :request do
    include ::Docs::V1::Graphql::Tags::Destroy

    let(:owner) { create(:user) }
    let(:query) do
      { "query":
          "mutation deleteTag{
            deleteTag(input: { id: #{tag.id} })
            { tag { id } }
          }" }
    end

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'the tag to delete exists and is owned by current user' do
      let(:tag) { create(:tag, user_id: owner.id) }

      it_behaves_like 'a successful request'

      it 'deletes the tag', :dox do
        expect{ ::Tag.find(tag.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'the tag to delete exists and is not owned by current user' do
      let(:tag) { create(:tag) }

      it_behaves_like 'a successful request'

      it 'does not delete the tag' do
        expect(::Tag.find(tag.id)).to eq tag
      end

      it 'returns an error message', :dox do
        expect(json[:data][:error]).to eq 'Tag not found'
      end
    end

    context 'the tag to delete does not exist' do
      let(:tag) { OpenStruct.new(id: 1) }

      it_behaves_like 'a successful request'

      it 'returns an error message', :dox do
        expect(json[:data][:error]).to eq 'Tag not found'
      end
    end
  end
end
