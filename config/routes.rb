Rails.application.routes.draw do

  resources :locations
  resources :events, only: [:index, :new, :create, :show, :update] do
    resources :participants, only: [:create, :new, :destroy]
  end

  get '/my-events', to: 'events#my_events'
  get '/attending', to: 'events#attending_events'

  root 'static#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :accounts, only: [:show]
  resources :registrations, only: [:new, :create]
  # resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
