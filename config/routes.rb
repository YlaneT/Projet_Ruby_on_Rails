Rails.application.routes.draw do
  devise_for :admins
  devise_for :users

  root :to => 'reservations#new'
  get 'index' => "reservations#index"

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :chambres do
    resources :reviews
  end
  resources :reservations
  resources :pages

  # require "sidekiq/web"
  # mount Sidekiq::Web => 'sidekiq'

end
