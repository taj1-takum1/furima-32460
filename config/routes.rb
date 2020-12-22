Rails.application.routes.draw do
  devise_for :users
  root to: 'items#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items do
    resources :purchase_records, only: [:index, :create]
  end
  resources :users, only: :show
  resources :cards, only: [:new, :create]
end
