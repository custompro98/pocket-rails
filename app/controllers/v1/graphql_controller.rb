module V1
  class GraphqlController < ::V1::ApplicationController

    before_action :log_query

    def execute
      result = PocketSchema.execute(query, variables: variables,
                                           context: context,
                                           operation_name: operation_name)
      json_response(response_from(result))
    end

    private

    def response_from(result)
      return result['data'] unless result['errors'].present?
      { error: result['errors'].first['message'] }.to_json
    end

    def query
      params[:query]
    end

    def variables
      ensure_hash(params[:variables])
    end

    def context
      { current_user: current_user }
    end

    def operation_name
      params[:operationName]
    end

    def ensure_hash(ambiguous_param)
      case ambiguous_param
      when String
        if ambiguous_param.present?
          ensure_hash(JSON.parse(ambiguous_param))
        else
          {}
        end
      when Hash, ActionController::Parameters
        ambiguous_param
      when nil
        {}
      else
        raise ArgumentError, "Unexpected parameter: #{ambiguous_param}"
      end
    end

    def log_query
      logger.info "***GraphQL query: #{query}***"
      puts ::GraphQLFormatter.new(query) if Rails.env.development?
    end
  end
end
