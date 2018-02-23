require 'rails_helper'

describe 'User', type: :request do
  describe 'Post /graphql - User' do
    let(:owner) { create(:user) }
    let(:query) { { query: "{user {id}}" } }
    let(:status) { :ok }

    before { post v1_graphql_path, params: query.to_json, headers: headers(owner) }

    it_behaves_like 'a successful request'
  end
end
