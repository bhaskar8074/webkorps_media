Rails.application.routes.draw do
  get 'friends/create'
  get 'friends/destroy'
  get "friends" => "friends#friends"
  get "users" => "user#index"
  delete '/user/:id', to: 'user#destroy', as: 'delete_user'
  devise_for :users
  resource :profile, only: [ :show, :edit, :update] do
    member do
      post 'send_friend_request'
    end
  end

  resources :messages, only: [:create, :show, :destroy]

  resources :friends do
    get :friend_requests, on: :collection
    post :accept_friend_request, on: :member
    delete :reject_friend_request, on: :member
  end

  get "profile/index"
  root "home#index"
  
end
