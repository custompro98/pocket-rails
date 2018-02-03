require 'rails_helper'

describe 'Authentication', type: :request do
  include ::Docs::V1::Authentication::Api

  describe 'sign up' do
    include ::Docs::V1::Authentication::SignUp

    let(:user_attrs) do
      {first_name: 'Test',
       last_name: 'SignUp',
       email: 'test.signup@example.com',
       password: 'TestSignUpPass',
       confirm_success_url: 'www.example.com'}
    end

    it 'signs the user up', :dox do
      post user_registration_path, params: user_attrs.to_json, headers: default_headers
    end
  end

  describe 'sign_in' do
    include ::Docs::V1::Authentication::SignIn

    let(:user) { create(:user) }
    let(:params) { {email: user.email, password: user.password} }

    it 'signs the user in', :dox do
      post user_session_path, params: params.to_json, headers: headers(user)
    end
  end

  describe 'sign_out' do
    include ::Docs::V1::Authentication::SignOut

    let(:user) { create(:user) }

    it 'signs the user in', :dox do
      delete destroy_user_session_path, headers: headers(user)
    end
  end
end
