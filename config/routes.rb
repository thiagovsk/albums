Rails.application.routes.draw do
  resources :albums
  resources :users, only: [:new, :create]

  get '/login'     => 'sessions#new'
  post '/login'    => 'sessions#create'
  delete '/logout' => 'sessions#destroy'

  root 'sessions#new'
end
