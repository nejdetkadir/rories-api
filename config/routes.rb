Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api, module: :api, constraints: { format: :json } do
    scope :v1, module: :v1 do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

      get '/feed', to: 'feed#index'

      # resources
      resources :genres, only: [:index, :show] do
        post '/follow', to: 'genres#follow'
        delete '/unfollow', to: 'genres#unfollow'
      end

      resources :cast, only: [:show] do
        post '/follow', to: 'cast#follow'
        delete '/unfollow', to: 'cast#unfollow'
      end

      resources :movies, only: [:index, :show] do
        post '/follow', to: 'movies#follow'
        delete '/unfollow', to: 'movies#unfollow'
      end

      # search movies
      post 'movies/search', to: 'movies#search'
    end
  end
end
