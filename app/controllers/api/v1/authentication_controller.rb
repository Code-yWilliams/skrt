module Api
  module V1
    class AuthenticationController < ApiController
      include Jwt
      skip_before_action :authenticate_user, only: %i[login refresh]

      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          access_token, refresh_token = AuthToken::GenerateService.call(user, increment_refresh_token: false)

          render json: { access_token:, refresh_token:, user: { id: user.id, name: user.name, email: user.email } }, status: :ok
        else
          raise ApiErrors::Auth::UnauthorizedError
        end
      end

      def refresh
        refresh_token = params[:refresh_token]
        decoded_refresh_token = decode_token(refresh_token)
        user = User.find(decoded_refresh_token[:user_id])

        if user.refresh_token_version == decoded_refresh_token[:version]
          access_token, refresh_token = AuthToken::GenerateService.call(user)

          render json: { access_token:, refresh_token:, user: { id: user.id, name: user.name, email: user.email } }, status: :ok
        else
          raise ApiErrors::Auth::UnauthorizedError
        end
      end
    end
  end
end
