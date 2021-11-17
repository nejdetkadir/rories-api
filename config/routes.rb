Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope :api, module: :api, constraints: { format: :json } do
    scope :v1, module: :v1 do
      devise_for :users, controllers: { sessions: 'users/sessions', registrations: 'users/registrations', passwords: 'users/passwords' }

      # resources
      resources :genres, only: [:index, :show] do
        get '/follow', to: 'genres#follow'
        delete '/unfollow', to: 'genres#unfollow'
      end

      resources :cast, only: [:show] do
        get '/follow', to: 'cast#follow'
        delete '/unfollow', to: 'cast#unfollow'
      end

      resources :movies, only: [:index, :show] do
        get '/follow', to: 'movies#follow'
        delete '/unfollow', to: 'movies#unfollow'
      end
    end
  end
end
