Rails.application.routes.draw do
  namespace :api do
    namespace :professors do
      resources :los
    end
  end
end
