module ExceptionHandler
  extend ActiveSupport::Concern

  class ResourceForbidden < StandardError; end

  included do
    rescue_from ActiveRecord::RecordNotFound do
      json_response({message: "#{object_type} not found"}, status: :not_found)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      json_response(
        {message: "#{object_type} cannot be #{params[:action]}d",
         errors: parse_errors(e)},
         status: :unprocessable_entity
      )
    end

    rescue_from ResourceForbidden do
      json_response({message: "#{object_type} is owned by a different user"}, status: :forbidden)
    end

    def parse_errors(e)
      e.record.errors.map { |field, message| {field: field, message: message}  }
    end

    def object_type
      self.class.name.match(/\S*::\S*::(\S*)Controller/)[1].singularize
    end
  end
end
