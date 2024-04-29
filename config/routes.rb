Rails.application.routes.draw do
  def draw(routes_name)
    route_parts = %w[config routes] + routes_name.to_s.split(File::SEPARATOR)
    filename = "#{route_parts.slice!(-1)}.rb"
    instance_eval(File.read(Rails.root.join(*(route_parts << filename))))
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  draw :api_routes
end
