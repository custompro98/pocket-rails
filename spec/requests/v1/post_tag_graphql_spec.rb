require 'rails_helper'

describe 'Tags', type: :request do
  include ::Docs::V1::Graphql::Tags::Api

  describe 'POST /graphql - Tags Mutation' do
    include ::Docs::V1::Graphql::Tags::Create

    let(:owner) { create(:user) }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    context 'when a valid tag is submitted' do
      let(:attributes) { {name: 'Test Tag'} }
      let(:query) do
        { "query":
            "mutation createTag{
              createTag(input: { name: \"GraphQL\" })
              { tag { id } }
            }" }
      end
      let(:status) { :ok }

      it_behaves_like 'a successful request'

      it 'includes selected fields from the bookmark' do
        expect(json[:data][:createTag][:tag][:id]).not_to be_nil
      end

      it 'creates a tag owned by current user', :dox do
        expect(::Tag.first.user_id).to eq(owner.id)
      end
    end

    context 'when an invalid tag is submitted' do
      let(:query) do
        { "query":
            "mutation createTag{
              createTag(input: {  })
              { tag { id } }
            }" }
      end
      let(:status) { :ok }

      let(:name_error) { {field: 'name', message: 'can\'t be blank'} }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unsuccessful message with errors', :dox do
        expect(json[:data][:message]).to eq 'Graphql cannot be executed'
        expect(json[:data][:errors].size).to eq 1
        expect(json[:data][:errors]).to include name_error
      end
    end
  end
end
