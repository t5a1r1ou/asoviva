Rails.application.routes.draw do
  root "static_pages#home"
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  resources :users, only: [:index, :show, :edit, :update]
  resources :posts, except: [:new]
end
