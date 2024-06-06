module AuthToken
  class GenerateService < BaseService
    include Jwt

    def initialize(user, increment_refresh_token: true)
      @user = user
      @increment_refresh_token = increment_refresh_token
    end

    def call
      access_token = encode_access_token({user_id: @user.id})
      new_refresh_token_version = @increment_refresh_token ? @user.refresh_token_version + 1 : @user.refresh_token_version
      refresh_token = encode_refresh_token({user_id: @user.id}, version: new_refresh_token_version)
      @user.update!(refresh_token_version: new_refresh_token_version) if @increment_refresh_token

      return [access_token, refresh_token]
    end
  end
end
