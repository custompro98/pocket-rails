require 'rails_helper'

describe ::Types::UserType do
  let(:subject) { described_class }

  it 'has a name of bookmark' do
    expect(subject.name).to eq 'User'
  end

  it 'has keys for each bookmark attribute' do
    expect(subject.fields.keys.sort).to eq %w[id first_name last_name email].sort
  end
end
