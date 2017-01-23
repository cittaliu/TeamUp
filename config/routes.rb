Rails.application.routes.draw do


  resources :meetings
  resources :events

  get 'teams/index'

  get 'teams/new'

  get 'teams/show'

  get 'teams/destroy'

  get '/', to: 'users#index', as: 'users'

  # User Signup & Login/Logout
  get '/signup', to: 'users#new', as: 'signup'
  post '/users', to: 'users#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  # User Pages
  get '/users/:id', to: 'users#show', as: 'user'
  get '/users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch '/users/:id', to: 'users#update'

  # Search for user
  get '/search', to: 'users#search', as: 'search_users'



  #Team Pages
  resources :teams do
    resources :users
  end

  # Prefix Verb   URI Pattern                              Controller#Action
  #          users GET    /                                        users#index
  #         signup GET    /signup(.:format)                        users#new
  #                POST   /users(.:format)                         users#create
  #          login GET    /login(.:format)                         sessions#new
  #                POST   /login(.:format)                         sessions#create
  #         logout GET    /logout(.:format)                        sessions#destroy
  #           user GET    /users/:id(.:format)                     users#show
  #      edit_user GET    /users/:id/edit(.:format)                users#edit
  #                PATCH  /users/:id(.:format)                     users#update
  #     team_users GET    /teams/:team_id/users(.:format)          users#index
  #                POST   /teams/:team_id/users(.:format)          users#create
  #  new_team_user GET    /teams/:team_id/users/new(.:format)      users#new
  # edit_team_user GET    /teams/:team_id/users/:id/edit(.:format) users#edit
  #      team_user GET    /teams/:team_id/users/:id(.:format)      users#show
  #                PATCH  /teams/:team_id/users/:id(.:format)      users#update
  #                PUT    /teams/:team_id/users/:id(.:format)      users#update
  #                DELETE /teams/:team_id/users/:id(.:format)      users#destroy
  #          teams GET    /teams(.:format)                         teams#index
  #                POST   /teams(.:format)                         teams#create
  #       new_team GET    /teams/new(.:format)                     teams#new
  #      edit_team GET    /teams/:id/edit(.:format)                teams#edit
  #           team GET    /teams/:id(.:format)                     teams#show
  #                PATCH  /teams/:id(.:format)                     teams#update
  #                PUT    /teams/:id(.:format)                     teams#update
  #                DELETE /teams/:id(.:format)                     teams#destroy

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
