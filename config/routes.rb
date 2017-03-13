Rails.application.routes.draw do


  resources :locations do
    resources :events, only: [:index, :show]
  end
  resources :events, only: [:index, :new, :create, :show, :update] do
    resources :participants, only: [:create, :destroy]
    resources :comments, only: [:create, :update, :destroy]
  end

  get '/my-events', to: 'events#my_events'
  get '/attending', to: 'events#attending_events'

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
