Rails.application.routes.draw do
  devise_for :users
  namespace :api, defaults: { format: :json }, path: '/' do
    scope module: :v1 do

    end
  end
end
