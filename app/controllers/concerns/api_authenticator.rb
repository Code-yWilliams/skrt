module ApiAuthenticator
  extend ActiveSupport::Concern
  include Jwt

  included do
    before_action :authenticate_user
  end

  private

  def authenticate_user
    authorization_header = request.headers['Authorization']
    token = authorization_header.split(' ').last if authorization_header

    if token
      begin
        decoded_token = decode_token(token)
        user_id = decoded_token[:user_id]
        @current_user = User.find(user_id)
      rescue JWT::ExpiredSignature
        raise ApiErrors::Auth::ExpiredTokenError
      rescue JWT::DecodeError
        raise ApiErrors::Auth::InvalidTokenError
      rescue ActiveRecord::RecordNotFound
        raise ApiErrors::Auth::InvalidTokenError
      end
    else
      raise ApiErrors::Auth::UnauthorizedError
    end
  end
end
