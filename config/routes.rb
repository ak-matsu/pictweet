Rails.application.routes.draw do
  devise_for :users
  # /とパスが指定されてもトップページに戻れるように設定
  root to: 'tweets#index'
  resources :tweets do
    resources :comments, only: :create
    collection do
      get 'search'
    end
  end
  resources :users, only: :show
end