module Api
  module V1
    class ApplicationController < ::ApplicationController
      include Responder
      include ExceptionHandler

      before_action :authenticate_user!

      def limit
        10
      end

      def offset
        params[:page].present? ? ((params[:page].to_i - 1) * limit) : 0
      end
    end
  end
end
