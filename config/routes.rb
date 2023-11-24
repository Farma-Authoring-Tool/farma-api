Rails.application.routes.draw do
  devise_for :users,
             defaults: { format: :json },
             path: '', path_names: {
                         sign_in: 'login',
                         sign_out: 'logout',
                         registration: 'signup'
                       },
             controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations'
             }

  authenticate :user do
    namespace :api do
      namespace :professors do
        resources :los do
          post 'duplicate', on: :member
          resources :introductions do
            post 'duplicate', on: :member
          end
          resources :exercises do
            post 'duplicate', on: :member
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
