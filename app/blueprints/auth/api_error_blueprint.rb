module Auth
  class ApiErrorBlueprint < Blueprinter::Base
    fields :status, :code, :message
  end
end
