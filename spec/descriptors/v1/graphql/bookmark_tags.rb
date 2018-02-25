module Docs
  module V1
    module Graphql
      module BookmarkTags
        extend Dox::DSL::Syntax

        document :api do
          resource 'Bookmark Tags - GraphQL' do
          endpoint '/grpahql'
          group 'Bookmark Tags'
          end
        end

        document :create do
          action 'Add a tag to a bookmark'
        end

        document :destroy do
          action 'Remove a tag from a bookmark'
        end
      end
    end
  end
end
