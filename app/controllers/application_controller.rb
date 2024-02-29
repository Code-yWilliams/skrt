class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    authorization_header = User.find_by(auth_token: request.headers['Authorization'])
    token = authorization_header.split(' ').last if authorization_header

    if token
      begin
        decoded_token = decode_token(token)
        user_id = decoded_token[:user_id]
        @current_user = User.find(user_id)
      rescue JWT::ExpiredSignature
        render json: { error: 'Expired token' }, status: :unauthorized
      rescue JWT::DecodeError
        render json: { error: 'Invalid token' }, status: :unauthorized
      rescue ActiveRecord::RecordNotFound
        render json: { error: 'Login Error' }, status: :unauthorized
      end
    else
      render json: { error: 'No token' }, status: :unauthorized
    end
  end

end
