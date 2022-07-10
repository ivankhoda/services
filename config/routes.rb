Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/client', to: 'clients#create'
  get '/client/:id', to: 'clients#show'
  patch '/client/:id', to: 'clients#update'
  delete '/client/:id', to: 'clients#destroy'
  get '/clients', to: 'clients#index'

  post '/assignee', to: 'assignees#create'
  get '/assignee/:id', to: 'assignees#show'
  patch '/assignee/:id', to: 'assignees#update'
  delete '/assignee/:id', to: 'assignees#destroy'
  get '/assignees', to: 'assignees#index'

  post '/category', to: 'categories#create'
  get '/category/:id', to: 'categories#show'
  patch '/category/:id', to: 'categories#update'
  delete '/category/:id', to: 'categories#destroy'
  get '/categories', to: 'categories#index'

  post '/service', to: 'services#create'
  get '/service/:id', to: 'services#show'
  patch '/service/:id', to: 'services#update'
  delete '/service/:id', to: 'services#destroy'
  get '/services', to: 'services#index'

  post '/generic-service', to: 'generic_service#create'
  get '/generic-service/:id', to: 'generic_service#show'
  patch '/generic-service/:id', to: 'generic_services#update'
  delete '/generic-service/:id', to: 'generic_services#destroy'
  get '/generic-services', to: 'generic_services#index'

  post '/order', to: 'orders#create'
  get '/order/:id', to: 'orders#show'
  patch '/order/:id', to: 'orders#update'
  delete '/order/:id', to: 'orders#destroy'
  get '/orders', to: 'orders#index'
  get '/orders/export', to: 'orders#export'
end
