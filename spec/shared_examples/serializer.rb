shared_examples 'a serializer' do
  it 'serializes an object' do
    expect(JSON.parse(described_class.new(obj).to_json)['id']).to eq obj.id
  end
end
