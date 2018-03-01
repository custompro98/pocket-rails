require 'rails_helper'

describe ::Types::BookmarkType do
  let(:subject) { described_class }

  it 'has a name of bookmark' do
    expect(subject.name).to eq 'Bookmark'
  end

  it 'has keys for each bookmark attribute' do
    expect(subject.fields.keys.sort).to eq %w[id title url favorite archived owner tags].sort
  end

  it 'resolves the owner field' do
    current_user = OpenStruct.new

    expect(subject.fields['owner'].resolve(nil, {}, { current_user: current_user })).to eq(current_user)
  end

  it 'resolves the tags field' do
    bookmark = create(:bookmark)
    expect(subject.fields['tags'].resolve(bookmark, {}, {})).to eq(bookmark.tags)
  end
end
