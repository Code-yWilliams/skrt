module Api
  module V1
    class ApiController < ActionController::API
      include ApiAuthenticator
      include ApiErrorHandler
    end
  end
end
