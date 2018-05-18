Rails.application.routes.draw do
  namespace :admin do
    resources :articles do
    end
    root 'articles#index'
  end
  resources :article
  get 'check' => 'article#checkUser'
  root 'article#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
