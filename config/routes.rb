Rails.application.routes.draw do



  resources :locations do
    resources :events, only: [:index]
  end
  resources :events, only: [:index, :new, :create, :show, :update] do
    resources :participants, only: [:create, :destroy, :update]
    resources :comments, only: [:create, :update, :destroy]
  end
  post '/locations/confirm', to: 'locations#confirm'
  # /////Bootstrap Stuff/////
  get 'events/:id/edit', to: 'events#edit', :as => :edit
  # get 'locations/:id/edit', to: 'events#edit', :as => :edit_location

  get '/my-events', to: 'events#my_events'
  get '/attending', to: 'events#attending_events'

  root 'static#home'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/locations/newevent', to: 'locations#new_event'

  resources :accounts, only: [:show] do
    collection do
      get "/favorites/locations", to: "locations#favorites"
    end
  end

  resources :registrations, only: [:new, :create]
  # resources :accounts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
