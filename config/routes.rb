Rails.application.routes.draw do
  get 'teams', to: 'teams#index', as: :teams
end
