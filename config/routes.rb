Clubber::Application.routes.draw do
  apipie
  devise_for :users

  root to: 'apipie/apipies#index'

  namespace :api, defaults: { format: :json }, path: '/api/v1' do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy, :index] do
        resources :offers, only: [:create, :update ,:destroy]
        resources :bookings, only: [:create, :update ,:destroy]
        resources :events, only: [:create, :update ,:destroy]
        resources :invites, only: [:create, :update ,:destroy]
      end
      resources :sessions, only: [:create, :destroy]
      resources :offers, only: [:show, :index]
      resources :items, only: [:create, :update ,:destroy, :show, :index]
      resources :bookings, only: [:show, :index]
      resources :events, only: [:show, :index]
      resources :invites, only: [:show, :index]
    end
  end
end
