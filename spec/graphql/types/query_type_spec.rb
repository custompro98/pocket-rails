require 'rails_helper'

describe ::Types::QueryType do
  let(:subject) { described_class }

  it 'has a name of query' do
    expect(subject.name).to eq 'Query'
  end

  it 'has keys for each tag attribute' do
    expect(subject.fields.keys.sort).to eq %w[user bookmarks bookmark tags].sort
  end

  it 'has a user type' do
    user_field = subject.fields['user']
    user = OpenStruct.new

    expect(user_field.resolve(nil, {}, { current_user: user })).to eq user
  end

  it 'has a bookmarks type' do
    bookmarks_type = subject.fields['bookmarks']
    user = OpenStruct.new(id: 1)

    expect(bookmarks_type.resolve(nil, {}, { current_user: user })).to eq []
  end

  it 'has a bookmark type' do
    bookmark_type = subject.fields['bookmark']
    user = create(:user)
    bookmark = create(:bookmark, user_id: user.id)

    expect(bookmark_type.resolve(nil, { id: bookmark.id }, { current_user: user })).to eq bookmark
  end

  it 'has a tags type' do
    tags_type = subject.fields['tags']
    user = OpenStruct.new(id: 1)

    expect(tags_type.resolve(nil, {}, { current_user: user })).to eq []
  end
end
