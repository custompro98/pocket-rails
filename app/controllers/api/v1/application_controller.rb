module Api
  module V1
    class ApplicationController < ::ApplicationController
      include Responder
      include ExceptionHandler

      before_action :authenticate_user!
    end
  end
end
