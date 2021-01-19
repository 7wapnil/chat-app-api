# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount ActionCable.server => '/cable'

  resources :users, only: [:create]
  resources :conversations, only: %i[index create]
  resources :messages, only: [:create]

  post '/login', to: 'users#login'
  get '/auto_login', to: 'users#auto_login'
end
