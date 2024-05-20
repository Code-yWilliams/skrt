scope default: {format: :json} do
  namespace :api do
    namespace :v1 do
      resources :users

      post "/login", to: "authentication#login"
      post "/signup", to: "users#create"
      get "/test", to: "users#test"
    end
  end
end