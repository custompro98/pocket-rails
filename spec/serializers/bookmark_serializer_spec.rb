require 'rails_helper'
require Rails.root.join('spec/shared_examples/serializer.rb')

describe ::BookmarkSerializer do
  let(:obj) { create(:bookmark) }

  it_behaves_like 'a serializer'
end
