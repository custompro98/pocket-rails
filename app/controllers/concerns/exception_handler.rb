module ExceptionHandler
  extend ActiveSupport::Concern

  class ResourceForbidden < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do |err|
      response = graphql? ? {error: "#{object_type_from(err)} not found"} : {message: "#{object_type} not found"}
      json_response(response, status: graphql? ? :ok : :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |err|
      json_response(
        {message: "#{object_type} cannot be #{params[:action]}d",
         errors: parse_errors(err)},
         status: graphql? ? :ok : :unprocessable_entity
      )
    end

    rescue_from ResourceForbidden do |err|
      response = graphql? ? {error: err.message} : {message: err.message}
      json_response(response, status: graphql? ? :ok : :forbidden)
    end

    def parse_errors(err)
      err.record.errors.map { |field, message| {field: field, message: message}  }
    end

    def object_type
      self.class.name.match(/\S*::(\S*)Controller/)[1].singularize
    end

    def object_type_from(err)
      err.message.match(/.*(Bookmark|Tag).*/)[1]
    end

    def graphql?
      controller_path.include?('graphql')
    end
  end
end
