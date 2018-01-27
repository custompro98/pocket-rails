shared_examples 'a successful request' do
  it 'returns a success status code' do
    expect(response).to have_http_status(status)
  end
end

shared_examples 'an unsuccessful request' do
  it "returns an error status code" do
    expect(response).to have_http_status(status)
  end
end
