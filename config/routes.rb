Rails.application.routes.draw do
  resources :fixtures, only: [:index, :show]

  resources :bor, only: [:index]

  get 'bor/:team_name/:id', to: 'bor#show', as: 'bor_details'

  root 'fixtures#index'
end
