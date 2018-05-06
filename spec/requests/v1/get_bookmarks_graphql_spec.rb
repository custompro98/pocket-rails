require 'rails_helper'

describe 'Bookmarks', type: :request do
  include ::Docs::V1::Graphql::Bookmarks::Api

  describe 'POST /graphql - Bookmarks' do
    include ::Docs::V1::Graphql::Bookmarks::Index

    let(:owner) { create(:user) }
    let(:status) { :ok }

    context 'there are no bookmarks that belong to current user' do
      let(:query) { { query: "{bookmarks {id}}"} }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      it_behaves_like 'a successful request'

      it 'returns an empty array' do
        expect(json[:data][:bookmarks]).to be_empty
      end
    end

    context 'there are fewer than the page limit bookmarks that belong to current user' do
      let!(:bookmarks) { create_list(:bookmark, 9, user_id: owner.id) }
      let!(:not_my_bookmark) { create(:bookmark) }
      let(:query) { { query: "{bookmarks {id title url favorite archived owner { id first_name last_name email}}}"} }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      it_behaves_like 'a successful request'

      it 'returns all bookmarks', :dox do
        expect(json[:data][:bookmarks]).not_to be_empty
        expect(json[:data][:bookmarks].size).to eq 9
      end
    end

    context 'there are more than the page limit bookmarks that belong to the current user' do
      let!(:bookmarks) { create_list(:bookmark, 19, user_id: owner.id) }
      let(:page) { 1 }
      let(:query) { { query: "{bookmarks(page: #{page}) {id}}"} }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      context 'page 1' do
        it 'returns the first 10 bookmarks', :dox do
          expect(json[:data][:bookmarks]).not_to be_empty
          expect(json[:data][:bookmarks].size).to eq 10
        end
      end

      context 'page 2' do
        let(:page) { 2 }

        it 'returns the next 9 bookmarks' do
          expect(json[:data][:bookmarks]).not_to be_empty
          expect(json[:data][:bookmarks].size).to eq 9
        end
      end
    end

    context 'a filter is applied for a tag the user owns' do
      let(:bookmarks) { create_list(:bookmark, 2, user_id: owner.id) }
      let(:tag) { create(:tag, user_id: owner.id, taggable: bookmarks.first) }
      let(:query) { { query: "{bookmarks(tag: #{tag.id}) {id title tags {id name favorite archived owner { id }}}}"} }

      before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

      it 'returns only the bookmarks with that tag', :dox do
        expect(json[:data][:bookmarks]).not_to be_empty
        expect(json[:data][:bookmarks].size).to eq 1
        expect(json[:data][:bookmarks].first[:title]).to eq bookmarks.first.title
      end
    end
  end
end
