module Docs
  module V1
    module BookmarkTags
      extend Dox::DSL::Syntax

      document :api do
        resource 'Bookmark Tags' do
        endpoint '/bookmarks/:bookmark_id/tags'
        group 'Bookmark Tags'
        end
      end

      document :index do
        action 'Get tags for a bookmark'
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
