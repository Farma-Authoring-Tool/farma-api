Rails.application.routes.draw do
  namespace :api do
    namespace :professors do
      resources :los do
        resources :introductions
      end
    end
  end
end
