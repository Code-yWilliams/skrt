require 'jwt'

module Jwt
  extend ActiveSupport::Concern

  protected

  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def encode_token(payload, expiration = 7.days.from_now)
    payload[:expiration] = expiration.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded_token)
  end
end
