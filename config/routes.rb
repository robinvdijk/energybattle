Energybattle::Application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  authenticated :user do
    root :to => "static_pages#dashboard", as: :authenticated_root
  end

  resources :notifications do
    patch :accept, on: :member
  end

  resources :readings

  resources :users do
      resources :readings
  end

  resources :battles do
    resources :readings
    patch :kick_request, on: :member
  end

  resources :team_relations do
    patch :invite, on: :member
    patch :switch, on: :member
  end

  root to: "static_pages#homepage"

  match '/theme', to: 'static_pages#theme', via: 'get'
  match '/gametype', to: 'static_pages#gametype', via: 'get'
  match '/meterstanden', to: 'readings#index', via: 'get'
  match '/invoeren', to: 'readings#new', via: 'get'
end
