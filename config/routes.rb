Rails.application.routes.draw do
  root 'welcome#index'
  get '/about' => "about#index"
  get '/login' => "sessions#new"
  get '/signup' => "sessions#create"
end
