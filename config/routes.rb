Rails.application.routes.draw do
  root to: 'home#index'
  namespace :api, format: 'json' do
    resources :articles
  end
  get '*path', to: 'home#index', constraints: lambda { |req|
    req.path.exclude? 'rails/active_storage'
  }
end
