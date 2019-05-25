# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'activities#new'
  resources :activities, only: %i[new create show]
  devise_for :users
end
