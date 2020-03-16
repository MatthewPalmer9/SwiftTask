Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :users, only: [:new, :create] do 
    resources :tasks, only: [:index, :show, :new]
  end 

  resources :projects
  resources :tasks


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
  get '/users/most_projects' => "users#most_projects"
  # Custom Routes #

  # ------ #

  # Users Routes #
  get '/signup' => "users#new"
  post '/signup' => "users#create"
  post '/users/:id/tasks/new' => "tasks#create"
  # Users Routes #

  # ------ #

  # Tasks Routes #
  get '/tasks/:id/complete' => "tasks#complete"
  # Tasks Routes # 

end
