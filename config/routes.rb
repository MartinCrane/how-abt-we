Rails.application.routes.draw do

  resources :locations
  resources :events, only: [:new, :create, :show] do
    resources :participants, only: [:create, :new, :destroy, :edit]
  end

  root 'static#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  post '/locations/confirm', to: 'locations#confirm'

  resources :accounts, only: [:show]
  resources :registrations, only: [:new, :create]
  # resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
