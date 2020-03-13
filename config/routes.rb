Rails.application.routes.draw do
  root 'welcome#index'
  resources :users
  resources :tasks
  resources :task_managers
  resources :task_groups

  # Sessions Routes #
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"
  get '/auth/facebook/callback' => "sessions#facebook"
  # Sessions Routes #

  # ------ #

  # Custom Routes #
  get '/about' => "about#index"
  get '/dashboard' => "users#dashboard"
  # Custom Routes #

  # Users Routes #
  get '/signup' => "users#new"
  post '/signup' => "users#create"
  # Users Routes #

end
