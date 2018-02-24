require 'rails_helper'

describe 'Tags', type: :request do
  describe 'POST /graphql - Tags' do
    let(:owner) { create(:user) }
    let(:status) { :ok }

    context 'there are no tags that belong to current user' do
      let(:query) { { query: "{tags {id}}" } }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      it_behaves_like 'a successful request'

      it 'returns an empty array' do
        expect(json[:tags]).to be_empty
      end
    end

    context 'there are fewer than the page limit tags that belong to current user' do
      let!(:tags) { create_list(:tag, 9, user_id: owner.id) }
      let!(:not_my_tag) { create(:tag) }
      let(:query) { { query: "{tags {id}}" } }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      it_behaves_like 'a successful request'

      it 'returns all tags' do
        expect(json[:tags]).not_to be_empty
        expect(json[:tags].size).to eq 9
      end
    end

    context 'there are more than the page limit tags that belong to the current user' do
      let!(:tags) { create_list(:tag, 19, user_id: owner.id) }
      let(:query) { { query: "{tags(page: #{page}) {id}}" } }
      let(:page) { 1 }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      context 'page 1' do
        it 'returns the first 10 tags' do
          expect(json[:tags]).not_to be_empty
          expect(json[:tags].size).to eq 10
        end
      end

      context 'page 2' do
        let(:page) { 2 }

        it 'returns the next 9 tags' do
          expect(json[:tags]).not_to be_empty
          expect(json[:tags].size).to eq 9
        end
      end
    end
  end
end