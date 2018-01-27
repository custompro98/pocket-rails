require Rails.root.join('spec/shared_examples/response_codes.rb')

module RequestSpecHelper
  def json
    JSON.parse(response.body).tap do |res|
      return res.map(&:deep_symbolize_keys) if res.is_a?(Array)
      return res.deep_symbolize_keys
    end
  end
end
