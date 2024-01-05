# frozen_string_literal: true

Rails.application.routes.draw do
  get 'users' => 'user#index'

  post 'toggle_like', to: 'likes#toggle_like', as: :toggle_like

  resources :posts, only: %i[new index create]
  delete '/user/:id', to: 'user#destroy', as: 'delete_user'
  devise_for :users
  resource :profile, only: %i[index show edit update] do
    member do
      post 'send_friend_request'
    end
  end

  resources :messages, only: %i[create show destroy]

  resources :friends, only: [:index] do
    get :friend_requests, on: :collection
    post :accept_friend_request, on: :member
    delete :reject_friend_request, on: :member
  end

  root 'home#index'
  get '/notfound' => 'errors#notfound'
  match '*unmatched', to: redirect('/notfound'), via: :all
end
