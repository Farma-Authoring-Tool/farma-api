Rails.application.routes.draw do
  get 'teams', to: 'teams#index', as: :teams
  get 'los', to: 'los#index', as: :los
  post 'los', to: 'los#create'
  get 'los/:id', to: 'los#show', as: :lo
  patch 'los/:id', to: 'los#update'
  delete 'los/:id', to: 'los#destroy'
end
