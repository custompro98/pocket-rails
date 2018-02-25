module Docs
  module V1
    module Bookmarks
      extend Dox::DSL::Syntax

      document :api do
        resource 'Bookmarks - REST' do
          endpoint '/bookmarks'
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
