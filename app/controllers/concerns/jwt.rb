require 'jwt'

module Jwt
  extend ActiveSupport::Concern

  protected

  SECRET_KEY = Rails.application.credentials.secret_key_base.to_s
  DEFAULT_ACCESS_TOKEN_EXPIRATION = Rails.application.credentials[:access_token_expire_minutes].to_i.minutes.from_now

  def encode_access_token(payload = {}, expiration: DEFAULT_ACCESS_TOKEN_EXPIRATION)
    payload[:exp] = expiration.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def encode_refresh_token(payload = {}, version: nil)
    raise Exception.new "refresh token is required" if version.nil?

    payload[:version] = version
    payload[:created_at] = Time.current.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def decode_token(token)
    decoded_token = JWT.decode(token, SECRET_KEY)[0]
    HashWithIndifferentAccess.new(decoded_token)
  end
end
