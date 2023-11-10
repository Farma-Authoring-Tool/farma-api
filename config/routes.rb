Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

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

  namespace :api do
    namespace :professors do
      resources :protected_resource, only: [:create, :update, :destroy]
    end
  end
end
