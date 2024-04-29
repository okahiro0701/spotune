Rails.application.routes.draw do
  devise_for :users
  resources :musics do
    collection {get "search"}
  end
  root to: "posts#index"
  resources :posts do
    collection {get "search"}
  end
  resources :users, only: :show
end
