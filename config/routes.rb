# frozen_string_literal: true

Rails.application.routes.draw do

  root 'recipes#public'

  get 'shopping_list', to: 'recipes#shopping_list'
  get 'shopping_list_inventory_recipe', to: 'recipes#shopping_list_inventory'
  resources :food_inventories
  # resources :shopping_list_recipes, only: [:index]
  resources :foods, except: [:update, :edit]

  resources :recipes, except: [:update, :edit ]
  resources :inventories, except: [:update, :edit]
  resources :recipe_foods, only: [:create, :show, :index, :new, :destroy ]
    get 'general_shopping_list', to: 'recipes#general_shopping_list'
   

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
