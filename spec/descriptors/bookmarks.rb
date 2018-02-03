module Docs
  module Bookmarks
    extend Dox::DSL::Syntax

    document :api do
      resource 'Bookmarks' do
      endpoint '/bookmarks'
      group 'Bookmarks'
      end
    end

    document :show do
      action 'Get bookmarks'
    end
  end
end
