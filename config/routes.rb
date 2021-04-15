Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/tristo_admin_page', as: 'rails_admin'
  namespace :api do
    get 'favorites/create'
    get 'favorites/destroy'
  end
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :countries, only: %i[index show]
    resources :regions, only: %i[show]
    resources :users do
      collection do
        get 'me'
      end
    end
    resources :relationships do
      member do
        post 'follow'
        get 'following'
        get 'followers'
        get 'count'
        get 'get_following_ids'
      end
      collection do
        get 'get_following_ids'
      end
    end
    resources :sessions
    resources :articles do
      collection do
        get 'japan'
        post 'search'
      end
      member do
        get 'user_articles'
        get 'user_articles_draft'
        get 'user_favorites'
        get 'user_articles_count'
      end
    end
    resources :article_regions, only: %i[create destroy]
    resources :tags, only: %i[create]
    resources :article_tags, only: %i[create destroy]
    resources :days, only: %i[show create destroy]
    resources :blocks, only: %i[show create update destroy]
    resources :spendings, only: %i[create update destroy]
    resources :transportations, only: %i[create update destroy]
    resources :comments, only: %i[show create update destroy]
    resources :favorites do
      member do
        post 'favorite'
      end
    end
  end
  get '*path', to: 'home#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
