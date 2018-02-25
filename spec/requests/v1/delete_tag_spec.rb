require 'rails_helper'

describe 'Tags', type: :request do
  include ::Docs::V1::Tags::Api

  describe 'DELETE /tags/:id', type: :request do
    include ::Docs::V1::Tags::Destroy

    let(:owner) { create(:user) }

    before { delete v1_tag_path(tag), headers: headers(owner) }

    context 'the tag to delete exists and is owned by current user' do
      let(:tag) { create(:tag, user_id: owner.id) }
      let(:status) { :no_content }

      it_behaves_like 'a successful request'

      it 'deletes the tag', :dox do
        expect{ ::Tag.find(tag.id) }.to raise_error(ActiveRecord::RecordNotFound)
      end
    end

    context 'the tag to delete exists and is not owned by current user' do
      let(:tag) { create(:tag) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'

      it 'does not delete the tag' do
        expect(::Tag.find(tag.id)).to eq tag
      end

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Tag not found'
      end
    end

    context 'the tag to delete does not exist' do
      let(:tag) { OpenStruct.new(id: 1) }
      let(:status) { :not_found }

      it_behaves_like 'an unsuccessful request'

      it 'returns an error message', :dox do
        expect(json[:message]).to eq 'Tag not found'
      end
    end
  end
end
