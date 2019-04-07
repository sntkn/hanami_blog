# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: "home#index"
resources :books, only: [:index, :new, :create]
post "/users", to: "users#create"
get "/users/sign_up", to: "users#sign_up"
get "/users/activate", to: "users#activate", as: :activate_user
