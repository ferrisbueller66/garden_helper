Rails.application.routes.draw do

  devise_for :users, :controllers => {:registrations => 'registrations', :omniauth_callbacks => 'callbacks'}
  devise_scope :user do
    get 'signin', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  resources :beds, only: [:index, :show, :new, :create, :edit, :update] do
    resources :plants, only: [:show, :new]
  end

  resources :plants, only: [:index, :show, :new, :create, :edit, :update] do 
    resources :harvests, only: [:show, :new, :create, :edit, :update]
  end

  resources :plants, only: [:index, :show, :new, :create, :edit, :update]
    resources :harvests, only: [:show, :new, :create, :update]
  delete "plants/plant_id/authors/:id", to: "harvests#destroy", as: "delete_plant_harvest"

  root 'application#welcome'
end