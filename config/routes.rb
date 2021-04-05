Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :countries, only: %i[index show]
    resources :users do
      collection do
        get 'me'
        patch 'update_current_user'
        delete 'destroy_current_user'
      end
    end
    resources :relationships do
      member do
        post 'follow'
        get 'following'
        get 'followers'
      end
    end
    resources :sessions
    resources :articles
    resources :article_regions, only: %i[create destroy]
    resources :tags, only: %i[create]
    resources :article_tags, only: %i[create destroy]
    resources :days, only: %i[show create destroy]
    resources :blocks, only: %i[show create update destroy]
    resources :spendings, only: %i[create update destroy]
    resources :transportations, only: %i[create update destroy]
    resources :comments, only: %i[show create update destroy]
  end
  get '*path', to: 'home#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
