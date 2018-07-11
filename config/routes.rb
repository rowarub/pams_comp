Rails.application.routes.draw do
  devise_for :managers, only: [:sign_in, :sign_out, :session]
  resources :managers do
    member do
      get 'relations'
    end
  end

  devise_for :users
  devise_scope :user do
      root :to => "users/sessions#new"
  end


  resources :pams_answers, only: [:index, :show, :edit, :update, :create]
  resources :users, only: [:edit, :update, :new, :create]


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
end
