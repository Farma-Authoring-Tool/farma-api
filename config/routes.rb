Rails.application.routes.draw do
  namespace :api do
    namespace :professors do
      resources :los
      resources :introductions
    end
  end
end
