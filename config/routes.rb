Rails.application.routes.draw do
  devise_for :users, defaults: { format: :json },
                     path: '', path_names: {
                       sign_in: 'login',
                       sign_out: 'logout',
                       registration: 'signup'
                     }

  authenticate :user do
    namespace :api do
      namespace :professors do
        resources :los do
          resources :introductions
          resources :exercises do
            resources :solution_steps do
              post 'duplicate', on: :member
              resources :tips do
                post 'duplicate', on: :member
              end
            end
          end
        end
      end
    end
  end
end
