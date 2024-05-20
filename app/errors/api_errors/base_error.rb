module ApiErrors
  class BaseError < StandardError
    include ActiveModel::Serialization

    attr_reader :status, :code, :message

    ERROR_DESCRIPTION = Proc.new {|code, message| {status: "error", code: code, message: message}}
    ERROR_CODE_MAP = {
      "Auth::UnauthorizedError" => [4010, "Invalid or missing credentials"],
      "Auth::NoTokenError" => [4010, "No token provided"],
      "Auth::InvalidTokenError" => [4010, "Invalid token"],
      "Auth::ExpiredTokenError" => [4010, "Expired token"],
    }

    def initialize
      error_type = self.class.name.scan(/ApiErrors::(.*)/).flatten.first

      error_code_data = ApiErrors::BaseError::ERROR_CODE_MAP.fetch(error_type, {})
      error_attributes = ApiErrors::BaseError::ERROR_DESCRIPTION.call(*error_code_data)
      error_attributes.each do |attr, error_data|
        instance_variable_set("@#{attr}".to_sym, error_data)
      end
    end

    def self.model_name
      ActiveModel::Name.new(self, nil, "ApiError")
    end
  end
end
