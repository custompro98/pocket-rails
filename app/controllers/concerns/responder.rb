module Responder
  def json_response(object = nil, status: :ok, headers: {})
    object.nil? ? head(status, headers) : render(json: {data: object}, status: status)
  end
end
