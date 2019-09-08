# frozen_string_literal: true

Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  root 'static_pages#home'
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  resources :users, only: %i[index show edit update] do
    resource :relationships, only: %i[create destroy]
    get :follows, on: :member
    get :followers, on: :member
    get :commented, on: :member
    get :comments, on: :member
  end

  resources :posts, except: :new do
    resource :stocks, only: %i[create destroy]
    resource :comments, only: %i[create destroy]
  end
end
