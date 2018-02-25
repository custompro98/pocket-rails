module Docs
  module V1
    module Tags
      extend Dox::DSL::Syntax

      document :api do
        resource 'Tags - REST' do
          endpoint '/tags'
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
