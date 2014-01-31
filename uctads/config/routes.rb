Uctads::Application.routes.draw do

  resources :categories, only: [:index, :show, :new, :create, :edit, :update]

end
