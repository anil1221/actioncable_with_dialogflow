Rails.application.routes.draw do
  get 'welcome/index'
  root to: 'welcome#index'
  post '/', to: 'rooms#index'
  get 'chat', to: 'rooms#show'
  get 'movies', to: 'rooms#movies'
  get 'chat_code', to: 'room#chat_code'
  post 'chat_code', to: 'room#chat_code'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #
  resources :users
  resources :sessions
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
