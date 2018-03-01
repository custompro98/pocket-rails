require 'rails_helper'
require Rails.root.join('spec/shared_examples/serializer.rb')

describe ::TagSerializer do
  let(:obj) { create(:tag) }

  it_behaves_like 'a serializer'
end
