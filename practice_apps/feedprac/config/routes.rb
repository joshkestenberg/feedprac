Rails.application.routes.draw do
  resource :sessions, only: [:new, :create, :destroy]

  resources :users do
    resources :orders
  end

  get '/users/:user_id/orders/:id/pickdrop', to: 'orders#pickdrop', as: :pickdrop
  get '/users/:user_id/orders/:id/approve', to: 'orders#approve', as: :approve
  get '/users/:user_id/orders/:id/deny', to: 'orders#deny', as: :deny


  root 'users#new'
end
