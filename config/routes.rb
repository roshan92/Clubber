Rails.application.routes.draw do
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      devise_for :users
      resources :users, only: [:show, :create, :update]
    end
  end
end
