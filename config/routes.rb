Rails.application.routes.draw do
  root 'welcome#index'
  get '/about' => "about#index"
end
