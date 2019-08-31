Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, except: [:new]
end
