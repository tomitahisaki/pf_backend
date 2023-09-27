# frozen_string_literal: true
require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get 'healthcheck', to: 'healthcheck#index'
  resources :todos

  mount Sidekiq::Web => '/sidekiq'
end
