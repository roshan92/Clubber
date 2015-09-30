Clubber::Application.routes.draw do
  apipie
  devise_for :users

  root to: 'apipie/apipies#index'

  namespace :api, defaults: { format: :json }, path: '/api/v1' do
    scope module: :v1 do
      resources :users, only: [:show, :create, :update, :destroy, :index]
      resources :sessions, only: [:create, :destroy]
      resources :offers, only: [:create, :update ,:destroy, :show, :index]
      resources :items, only: [:create, :update ,:destroy, :show, :index]
      resources :bookings, only: [:create, :update ,:destroy, :show, :index]
      resources :events, only: [:create, :update ,:destroy, :show, :index]
      resources :invites, only: [:create, :update ,:destroy, :show, :index]
    end
  end
end
