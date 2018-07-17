Rails.application.routes.draw do
  root 'posts#index'
  
  resources :posts

  get 'admin', to: 'posts#admin'
end
