Clubber::Application.routes.draw do
  devise_for :users

  mount SabisuRails::Engine => "/sabisu_rails"
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy, :index] do
        resources :offers, only: [:create, :update ,:destroy]
        resources :items, only: [:create, :update ,:destroy]
        resources :bookings, only: [:create, :update ,:destroy]
        resources :events, only: [:create, :update ,:destroy]
      end
      resources :sessions, only: [:create, :destroy]
      resources :offers, only: [:show, :index]
      resources :bookings, only: [:show, :index]
      resources :events, only: [:show, :index]
    end
  end
end
