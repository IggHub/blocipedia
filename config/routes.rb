Rails.application.routes.draw do

  resources :collaborators#, only: [:create, :destroy]
  resources :wikis
  root 'welcome#index'
  get 'about' => 'welcome#about'
  devise_for :users
  resources :charges, only: [:new, :create]
  get 'downgrade' => 'charges#downgrade'
end
