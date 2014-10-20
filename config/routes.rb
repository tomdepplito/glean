Rails.application.routes.draw do
  root 'application#index'
  #get '*path' => 'application#index'
  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'

  resources :users, only: [:new, :create]
end
