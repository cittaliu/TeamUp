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
  post '/add_user/:id', to: 'teams#add_to_team', as: 'add_user'

  # follow up on objectives
  post '/follow_up/:obj_param', to: 'objectives#follow_up', as: 'follow-up'

  #Team Pages
  resources :teams do
    resources :users
  end

  resources :objectives


#   Prefix Verb   URI Pattern                              Controller#Action
#      meetings GET    /meetings(.:format)                      meetings#index
#               POST   /meetings(.:format)                      meetings#create
#   new_meeting GET    /meetings/new(.:format)                  meetings#new
#  edit_meeting GET    /meetings/:id/edit(.:format)             meetings#edit
#       meeting GET    /meetings/:id(.:format)                  meetings#show
#               PATCH  /meetings/:id(.:format)                  meetings#update
#               PUT    /meetings/:id(.:format)                  meetings#update
#               DELETE /meetings/:id(.:format)                  meetings#destroy
#        events GET    /events(.:format)                        events#index
#               POST   /events(.:format)                        events#create
#     new_event GET    /events/new(.:format)                    events#new
#    edit_event GET    /events/:id/edit(.:format)               events#edit
#         event GET    /events/:id(.:format)                    events#show
#               PATCH  /events/:id(.:format)                    events#update
#               PUT    /events/:id(.:format)                    events#update
#               DELETE /events/:id(.:format)                    events#destroy
#   teams_index GET    /teams/index(.:format)                   teams#index
#     teams_new GET    /teams/new(.:format)                     teams#new
#    teams_show GET    /teams/show(.:format)                    teams#show
# teams_destroy GET    /teams/destroy(.:format)                 teams#destroy
#         users GET    /                                        users#index
#        signup GET    /signup(.:format)                        users#new
#               POST   /users(.:format)                         users#create
#         login GET    /login(.:format)                         sessions#new
#               POST   /login(.:format)                         sessions#create
#        logout GET    /logout(.:format)                        sessions#destroy
#          user GET    /users/:id(.:format)                     users#show
#     edit_user GET    /users/:id/edit(.:format)                users#edit
#               PATCH  /users/:id(.:format)                     users#update
#  search_users GET    /search(.:format)                        users#search
#      add_user POST   /add_user/:id(.:format)                  teams#add_to_team
#    team_users GET    /teams/:team_id/users(.:format)          users#index
#               POST   /teams/:team_id/users(.:format)          users#create
# new_team_user GET    /teams/:team_id/users/new(.:format)      users#new
# edit_team_user GET    /teams/:team_id/users/:id/edit(.:format) users#edit
#     team_user GET    /teams/:team_id/users/:id(.:format)      users#show
#               PATCH  /teams/:team_id/users/:id(.:format)      users#update
#               PUT    /teams/:team_id/users/:id(.:format)      users#update
#               DELETE /teams/:team_id/users/:id(.:format)      users#destroy
#         teams GET    /teams(.:format)                         teams#index
#               POST   /teams(.:format)                         teams#create
#      new_team GET    /teams/new(.:format)                     teams#new
#     edit_team GET    /teams/:id/edit(.:format)                teams#edit
#          team GET    /teams/:id(.:format)                     teams#show
#               PATCH  /teams/:id(.:format)                     teams#update
#               PUT    /teams/:id(.:format)                     teams#update
#               DELETE /teams/:id(.:format)                     teams#destroy
#    objectives GET    /objectives(.:format)                    objectives#index
#               POST   /objectives(.:format)                    objectives#create
# new_objective GET    /objectives/new(.:format)                objectives#new
# edit_objective GET    /objectives/:id/edit(.:format)           objectives#edit
#     objective GET    /objectives/:id(.:format)                objectives#show
#               PATCH  /objectives/:id(.:format)                objectives#update
#               PUT    /objectives/:id(.:format)                objectives#update
#               DELETE /objectives/:id(.:format)                objectives#destroy


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
