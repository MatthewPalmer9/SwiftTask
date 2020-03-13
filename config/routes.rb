Rails.application.routes.draw do
  root 'welcome#index'
  resources :users
  resources :tasks
  resources :task_managers
  resources :task_groups

  get '/about' => "about#index"
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  get '/signup' => "users#new"
  post '/signup' => "users#create"
  post '/logout' => "sessions#destroy"
  get '/auth/facebook/callback' => "sessions#facebook"
end
