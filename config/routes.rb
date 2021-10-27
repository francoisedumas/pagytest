Rails.application.routes.draw do
  resources :blog_posts do
    resources :comments, only: [:create]
  end
  root to: 'blog_posts#index'
end
