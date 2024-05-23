module ApiErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_error
  end

  private

  def render_error(error)
    raise error unless error.is_a?(ApiErrors::BaseError)

    render json: Auth::ApiErrorBlueprint.render(error), status: 200
  end
end
