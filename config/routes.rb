Rails.application.routes.draw do
  devise_for :users

  mount V1::Base => '/'
  
  root "home#welcome"

  get 'top_commenters' =>  'home#top_commenters', as: :top_commenters

  resources :genres, only: :index do
    member do
      get "movies"
    end
  end
  resources :movies, only: [:index, :show] do
    resources :comments, only: [:create, :destroy]
    member do
      get :send_info
    end
    collection do
      get :export
    end
  end
end
