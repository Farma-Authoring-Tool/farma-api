Rails.application.routes.draw do
  namespace :api do
    namespace :professors do
      resources :los do
        resources :introductions
        resources :exercises do
          resources :solution_steps do
            resources :tips
          end
        end
      end
    end
  end
end
