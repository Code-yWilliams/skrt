class AuthenticationController < ApplicationController
  include Jwt
  skip_before_action :authenticate_user, only: %i[login]

  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token(user_id: user.id)

      render json: { token: token, user: { id: user.id, email: user.email } }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
