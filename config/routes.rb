# frozen_string_literal: true

Rails.application.routes.draw do
  get 'posts' => 'posts#index'
  get 'posts/create'
  get 'friends/create'
  get 'friends/destroy'
  get 'friends' => 'friends#friends'
  get 'users' => 'user#index'

  post 'toggle_like', to: 'likes#toggle_like', as: :toggle_like

  resources :posts, only: %i[new index create]
  delete '/user/:id', to: 'user#destroy', as: 'delete_user'
  devise_for :users
  resource :profile, only: %i[show edit update] do
    member do
      post 'send_friend_request'
    end
  end

  resources :messages, only: %i[create show destroy]

  resources :friends do
    get :friend_requests, on: :collection
    post :accept_friend_request, on: :member
    delete :reject_friend_request, on: :member
  end

  get 'profile/index'
  root 'home#index'
  get '/notfound' => 'errors#notfound'
  match '*unmatched', to: redirect('/notfound'), via: :all
end
