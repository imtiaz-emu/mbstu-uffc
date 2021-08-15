Rails.application.routes.draw do
  resources :fixtures, only: [:index, :show]

  root 'fixtures#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
