require 'rails_helper'

describe 'Tags', type: :request do
  include ::Docs::V1::Tags::Api

  describe 'POST /tags' do
    include ::Docs::V1::Tags::Create

    let(:owner) { create(:user) }

    before { post v1_tags_path, params: attributes.to_json, headers: headers(owner) }

    context 'when a valid tag is submitted' do
      let(:attributes) { {name: 'Test Tag'} }
      let(:status) { :created }

      it_behaves_like 'a successful request'

      it 'includes a location header to redirect back to the tag index' do
        expect(response.headers['Location']).not_to be_nil
        expect(response.headers['Location']).to eq v1_tags_path
      end

      it 'creates a tag owned by current user', :dox do
        expect(::Tag.first.user_id).to eq(owner.id)
      end
    end

    context 'when an invalid tag is submitted' do
      let(:attributes) { {} }
      let(:status) { :unprocessable_entity }

      let(:name_error) { {field: 'name', message: 'can\'t be blank'} }

      it_behaves_like 'an unsuccessful request'

      it 'returns an unsuccessful message with errors', :dox do
        expect(json[:message]).to eq 'Tag cannot be created'
        expect(json[:errors].size).to eq 1
        expect(json[:errors]).to include name_error
      end
    end
  end
end
