module Docs
  module V1
    module Graphql
      module Bookmarks
        extend Dox::DSL::Syntax

        document :api do
          resource 'Bookmarks - GraphQL' do
            endpoint '/graphql'
            group 'Bookmarks'
          end
        end

        document :index do
          action 'Get bookmarks'
        end

        document :show do
          action 'Get a bookmark'
        end

        document :create do
          action 'Create a bookmark'
        end

        document :update do
          action 'Update a bookmark'
        end

        document :destroy do
          action 'Delete a bookmark'
        end
      end
    end
  end
end
