# frozen_string_literal: true

Rails.application.routes.draw do

  resources :food_inventories

  resources :foods, except: [:update, :edit]

  resources :recipes, except: [:update, :edit ]
  resources :inventories, except: [:update, :edit]
  resources :recipe_foods, only: [:create, :show, :index, :new, :destroy ]

  devise_for :users, controllers: {
        sessions: 'users/sessions',
        registrations: 'users/registrations'
      }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  # root 'recipes#index'
end
