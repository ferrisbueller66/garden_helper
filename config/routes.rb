Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'registrations', :omniauth_callbacks => 'callbacks'}
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  get 'user', to: 'users#show'

  resources :beds, only: [:index, :show, :new, :create, :edit, :update] do
    resources :plants, only: [:show]
  end
  resources :plants, only: [:index, :show, :new, :create, :edit, :update]
  

  root 'application#welcome'
end
