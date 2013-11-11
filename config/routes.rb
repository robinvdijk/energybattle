Energybattle::Application.routes.draw do
  resources :notifications do
	  patch :accept, on: :member
  end

  resources :readings

  resources :users do
      resources :readings
  end

  resources :battles

  resources :team_relations do
	  patch :invite, on: :member
	  patch :switch, on: :member
  end

  root "static_pages#theme"

  match '/theme', to: 'static_pages#theme', via: 'get'
  match '/gametype', to: 'static_pages#gametype', via: 'get'
  match '/meterstanden', to: 'readings#index', via: 'get'
  match '/invoeren', to: 'readings#new', via: 'get'
end
