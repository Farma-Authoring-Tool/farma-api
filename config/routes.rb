Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
                     path: '', path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       registration: 'signup'
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
end
