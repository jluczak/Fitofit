Rails.application.routes.draw do
  get 'activities/new'
  get 'activities/create'
  get 'activities/show'
  devise_for :users
end
