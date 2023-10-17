Rails.application.routes.draw do
  namespace :api do
    namespace :professors do
      resources :los do
        resources :introductions
        resources :exercises
      end
    end
  end
end
