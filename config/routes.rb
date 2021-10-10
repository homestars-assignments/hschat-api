Rails.application.routes.draw do

  # Visualizing api documentation for this demo
  root to: redirect('/api-doc')

  # Auth routes
  post '/auth/login', to: 'auth#login'

  ##
  # Main business logic routes
  # --------------------------

  # Channels with routes for CRUD ops
  # Used listing and nested features for the assignment but...
  # TODO: rol/based authorization for yet (not implemented at the moment)
  resources :channels do
    # Nested routes for channel ops join/leave
    member do             # Channel operations for current user
      post 'join'         # Join a channel
      post 'leave'        # Leave a channel
    end

    ##
    # Messages of a channel (nested resource routes)
    # List channel messages or write a new message in the channel.
    # No edit/destroy here, done directly on `/messages` bellow. (check `only:` sentence)
    resources :messages, only: %i[index create]
  end

  ##
  # Users CRUD
  resources :users, param: :_username
  # TODO: 👆 Nested resource route for private messages between current user and others. (not implemented at the moment)

  # Messages CRUD
  # No bulk-listing here, done in specific channel or user above. (check `only:` sentence)
  resources :messages, only: %i[show edit update destroy]

end
