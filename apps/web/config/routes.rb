# Configure your routes here
# See: http://hanamirb.org/guides/routing/overview/
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }

root to: "home#index"
resources :books, only: [:index, :new, :create]
get "/users/sign_up", to: "users#sign_up", as: :sign_up_user
get '/users/sign_in', to: 'users#sign_in', as: :sign_in_user
post '/users/authenticate', to: 'users#authenticate', as: :authenticate_user
namespace :user do
  resources :password_forgots, only: [:index, :create]
end
resources :users do
  resources :password_resets, only: [:edit, :update]
  member do
    get "activate"
    get 'email_edit'
    post 'email_update'
    get 'email_confirm'
    get 'password_edit'
    patch 'password_update'
    get 'sign_out'
  end
end
