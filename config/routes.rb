Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :blogs
      resources :categories, only: [:index]
      resources :tags, only: [:index]
      resources :users
      post '/login', to: 'authentication#login'
      # Define other routes as needed
    end
  end
end
