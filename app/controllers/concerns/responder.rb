module Responder
  def json_response(object = nil, status: :ok, headers: {})
    object.nil? ? head(status, headers) : render(json: json(object), status: status )
  end

  private

  def json(object)
    params[:controller].include?('graphql') ? graphql_json(object) : rest_json(object)
  end

  def graphql_json(object)
    { data: object }
  end

  def rest_json(object)
    object
  end
end
