# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: %i[index show edit update] do
    resource :relationships, only: %i[create destroy]
    post :follows, on: :collection
    post :followers, on: :collection
    post :mutual_follow, on: :collection
  end

  resources :posts, except: :new do
    resource :stocks, only: %i[create destroy]
    resource :comments, only: %i[create destroy]
    get 'rooms/show', on: :member
  end

  resources :events, only: %i[index] do
    post :result, on: :collection
    post :event_form, on: :collection
  end

  get 'relationships/create'
  get 'relationships/destroy'

  mount ActionCable.server => '/cable'
end
