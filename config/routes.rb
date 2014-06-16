Uctads::Application.routes.draw do

  # == categories routing ==
  get '/categories',          to: 'categories#index',   as: 'categories'
  get '/categories/new',      to: 'categories#new',     as: 'new_category'
  post '/categories',         to: 'categories#create',  as: 'create_category'
  get '/categories/:id',      to: 'categories#show',    as: 'show_category'
  get '/categories/:id/edit', to: 'categories#edit',    as: 'edit_category'
  patch '/categories/:id',    to: 'categories#update',  as: 'update_category'
  delete '/categories/:id',   to: 'categories#destroy', as: 'destroy_category'

  get '/categories/:id/ancestor_fields', to: 'categories#ancestor_fields'

  # == adverts routing ==
  get     '/adverts',                 to: 'adverts#index',              as: 'adverts'
  get     '/adverts_by_category/:id', to: 'adverts#index_by_category',  as: 'adverts_by_category'
  post    '/adverts',                 to: 'adverts#create',             as: 'create_advert'
  get     '/adverts/new',             to: 'adverts#new',                as: 'new_advert'
  get     '/adverts/:id',             to: 'adverts#show',               as: 'show_advert'
  get     '/adverts/:id/edit',        to: 'adverts#edit',               as: 'edit_advert'
  patch   '/adverts/:id',             to: 'adverts#update',             as: 'update_advert'
  delete  '/adverts/:id',             to: 'adverts#destroy',            as: 'destroy_advert'
  post    '/adverts/new_ad_form',     to: 'adverts#new_ad_form',        as: 'new_ad_form_advert'

  get     '/adverts/:id/gallery/edit',    to: 'adverts#edit_gallery',       as: 'edit_gallery'
  post    '/adverts/:id/gallery/upload', to: 'adverts#upload_to_gallery', as: 'upload_to_gallery'

  # == uploads routing ==
  get     '/uploads/:id',       to: 'uploads#show',     as: 'show_upload'
  get     '/uploads/:id/edit',  to: 'uploads#edit',     as: 'edit_upload'
  patch   '/uploads/:id',       to: 'uploads#update',   as: 'update_upload'
  delete  '/uploads/:id',       to: 'uploads#destroy',  as: 'destroy_upload'

  root 'adverts#index'


end
