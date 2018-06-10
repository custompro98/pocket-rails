require 'rails_helper'

describe ::Types::QueryType do
  let(:subject) { described_class }

  it 'has a name of query' do
    expect(subject.name).to eq 'Query'
  end

  it 'has a me field' do
    expect(subject.fields.keys.sort).to eq %w[me].sort
  end
end
