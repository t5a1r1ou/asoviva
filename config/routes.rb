Rails.application.routes.draw do
  root "static_pages#home"
  resources :posts, except: [:new]
end
