require 'rails_helper'

describe ::Types::UserType do
  let(:subject) { described_class }

  it 'has a name of user' do
    expect(subject.name).to eq 'User'
  end

  it 'has keys for each user attribute' do
    expect(subject.fields.keys).to include *%w[id first_name last_name email]
  end

  it 'has connections for tags' do
    expect(subject.fields['tags']).not_to be nil
  end

  it 'has connections for bookmarks' do
    expect(subject.fields['bookmarks']).not_to be nil
  end

  it 'has a bookmark field' do
    expect(subject.fields['bookmark']).not_to be nil
  end
end
