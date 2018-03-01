require 'rails_helper'

describe ::Types::MutationType do
  let(:subject) { described_class }

  it 'has a name of tag' do
    expect(subject.name).to eq 'Mutation'
  end

  it 'has keys for each tag attribute' do
    expect(subject.fields.keys.sort).to eq %w[createBookmark updateBookmark deleteBookmark createTag deleteTag addTag removeTag].sort
  end
end
