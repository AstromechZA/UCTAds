Uctads::Application.routes.draw do

  resources :categories

  get '/categories/:id/ancestor_fields', to: 'categories#ancestor_fields'

  get '/adverts', to: 'adverts#index'
  get '/adverts/new', to: 'adverts#new'
  post '/adverts/new_ad_form', to: 'adverts#new_ad_form'
  post '/adverts/create', to: 'adverts#create'

end
