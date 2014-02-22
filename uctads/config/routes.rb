Uctads::Application.routes.draw do

  resources :categories

  get '/categories/:id/ancestor_fields', to: 'categories#ancestor_fields'

  resources :adverts

  post '/adverts/new_ad_form', to: 'adverts#new_ad_form'

end
