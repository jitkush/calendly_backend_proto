Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # agent routes
  get 'agent/list', to: 'agent#list'
  post 'agent/add', to: 'agent#add'
  patch 'agent/update/:id', to: 'agent#update'
  get 'agent/show/:id', to: 'agent#show'
  delete 'agent/remove/:id', to: 'agent#remove_agent'

  # client routes
  get 'client/list', to: 'client#list'
  post 'client/add', to: 'client#add'
  patch 'client/update/:id', to: 'client#update'
  get 'client/show/:id', to: 'client#show'
  delete 'client/remove/:id', to: 'client#remove_client'

  # meeting routes
  post '/meeting/add/', to: 'meeting#add_meeting'
  get '/meeting/all', to: 'meeting#all_meeting'
  get 'meeting/agent/upcoming/:id', to: 'meeting#view_agent_meeting'
  get 'meeting/client/upcoming/:id', to: 'meeting#view_client_meeting'
end
