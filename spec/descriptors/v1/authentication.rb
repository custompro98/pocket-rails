module Docs
  module V1
    module Authentication
      extend Dox::DSL::Syntax

      document :api do
        resource 'Authentication' do
        endpoint 'auth'
        group 'Authentication'
        end
      end

      document :sign_up do
        action 'Sign up for an account'
      end

      document :sign_in do
        action 'Sign into an account'
      end

      document :sign_out do
        action 'Sign out of an account'
      end
    end
  end
end
