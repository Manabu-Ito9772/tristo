Rails.application.routes.draw do
  namespace :api do
    get 'article_tags/create'
  end
  namespace :api do
    get 'tags/create'
  end
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :countries, only: %i[index show]
    resources :articles
    resources :article_regions, only: %i[create destroy]
    resources :tags, only: %i[create]
    resources :article_tags, only: %i[create destroy]
    resources :days, only: %i[show create destroy]
    resources :blocks, only: %i[show create update destroy]
    resources :spendings, only: %i[create update destroy]
    resources :transportations, only: %i[create update destroy]
  end
  get '*path', to: 'home#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
