require 'dox'
require Rails.root.join('spec/shared_examples/response_codes.rb')
Dir[Rails.root.join('spec/descriptors/**/*.rb')].each { |f| require f }

Dox.configure do |config|
  config.headers_whitelist = ['Location', 'access-token', 'client', 'expiry', 'uid']
end

module RequestSpecHelper
  def headers(user = nil)
    default_headers.merge((user || create(:user)).create_new_auth_token)
  end

  def default_headers
    {'ACCEPT' => 'application/json',
     'CONTENT-TYPE' => 'application/json'}
  end

  def json
    JSON.parse(response.body).tap do |res|
      return res.map(&:deep_symbolize_keys) if res.is_a?(Array)
      return res.deep_symbolize_keys
    end
  end
end
