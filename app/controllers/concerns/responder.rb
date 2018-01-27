module Responder
  def json_response(object = nil, status: :ok, headers: {})
    object.nil? ? head(status, headers) : render(json: object, status: status)
  end
end
