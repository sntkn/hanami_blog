# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: "home#index"
resources :books, only: [:index, :new, :create]
post "/users", to: "users#create", as: :create_user
get "/users/sign_up", to: "users#sign_up", as: :sign_up_user
get "/users/activate", to: "users#activate", as: :activate_user
get '/users/sign_in', to: 'users#sign_in', as: :sign_in_user
post '/users/authenticate', to: 'users#authenticate', as: :authenticate_user
get '/users/sign_out', to: 'users#sign_out', as: :sign_out_user
