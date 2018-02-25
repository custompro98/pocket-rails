module Docs
  module V1
    module Graphql
      module Tags
        extend Dox::DSL::Syntax

        document :api do
          resource 'Tags - GraphQL' do
            endpoint '/graphql'
            group 'Tags'
          end
        end

        document :index do
          action 'Get tags'
        end

        document :create do
          action 'Create a tag'
        end

        document :destroy do
          action 'Delete a tag'
        end
      end
    end
  end
end
