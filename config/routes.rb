Rails.application.routes.draw do
  
  get 'attendances/index'
  get 'users/show'

  devise_for :users
  root to: 'events#index'


  resources :users do
    resources :avatars, only:[:create]
  end

  resources :events do
    resources :pictures, only:[:create]
  end

  
  resources :charges
  resources :attendances

  post 'create_attendance' => 'attendances#create', as: :create_attendance

 namespace :gods do
  get 'index'
  resources :users
  resources :events
  end
end
