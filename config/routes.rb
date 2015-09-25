Clubber::Application.routes.draw do
  devise_for :users

  mount SabisuRails::Engine => "/sabisu_rails"
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy, :index]
      resources :sessions, only: [:create, :destroy]
      resources :offers, only: [:show, :index]
    end
  end
end
