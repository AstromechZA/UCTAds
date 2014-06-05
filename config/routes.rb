Uctads::Application.routes.draw do

  # == categories routing ==
  get '/categories', to: 'categories#index', as: 'categories'
  get '/categories/new', to: 'categories#new', as: 'new_category'
  post '/categories', to: 'categories#create', as: 'create_category'
  get '/categories/:id', to: 'categories#show', as: 'show_category'
  get '/categories/:id/edit', to: 'categories#edit', as: 'edit_category'
  put '/categories/:id', to: 'categories#update', as: 'update_category'
  delete '/categories/:id', to: 'categories#destroy', as: 'destroy_category'

  get '/categories/:id/ancestor_fields', to: 'categories#ancestor_fields'

  # == adverts routing ==

  resources :adverts

  post '/adverts/new_ad_form', to: 'adverts#new_ad_form'

  resources :uploads

end
