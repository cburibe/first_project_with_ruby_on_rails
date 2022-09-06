Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
=begin
  delete '/products/:id', to: 'products#destroy'
  patch '/products/:id', to: 'products#update'
  post 'products', to: 'products#create'
  get 'products/new', to: 'products#new', as: :new_product
  get '/products', to: 'products#index'
  get '/products/:id', to: 'products#show', as: :product
  get '/products/:id/edit', to: 'products#edit', as: :edit_product
=end
  post '/upload', to: 'products#upload'
  get '/add_product', to: 'products#add_product'
  resources :products, path: '/'
  # Defines the root path route ("/")
  # root "articles#index"
end
