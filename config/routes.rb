Energybattle::Application.routes.draw do
  resources :readings
  resources :users
  resources :battles

  resources :team_relations do
    patch :switch, on: :member
  end

  root "static_pages#theme"

  match '/theme', to: 'static_pages#theme', via: 'get'
  match '/gametype', to: 'static_pages#gametype', via: 'get'
  match '/meterstanden', to: 'readings#index', via: 'get'
  match '/invoeren', to: 'readings#new', via: 'get'
end
