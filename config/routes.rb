# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'activities#new'
  get '/statistics', to: 'activities#index'
  resources :activities, only: %i[new create show]
  devise_for :users
end
