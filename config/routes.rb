Rails.application.routes.draw do
  get 'users/new'

  get 'users/create'

  get 'users/destroy'

  get '/', to: 'users#index', as: 'users'


  get '/signup', to: 'users#new', as: 'signup'
  post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get  '/logout', to: 'sessions#destroy'

  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
