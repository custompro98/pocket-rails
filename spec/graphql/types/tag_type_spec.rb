require 'rails_helper'

describe ::Types::TagType do
  let(:subject) { described_class }

  it 'has a name of tag' do
    expect(subject.name).to eq 'Tag'
  end

  it 'has keys for each tag attribute' do
    expect(subject.fields.keys.sort).to eq %w[id name favorite archived owner bookmarks].sort
  end

  it 'resolves the owner field' do
    current_user = OpenStruct.new

    expect(subject.fields['owner'].resolve(nil, {}, { current_user: current_user })).to eq(current_user)
  end
end
