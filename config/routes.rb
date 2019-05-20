Rails.application.routes.draw do

  resources :tag do
    collection do
      get :tag_name
    end
  end
  namespace :admin do
    resources :articles do
    end
    root 'articles#index'
  end
  resources :article do
    collection do
      get :search
    end
  end
  resources :users  
  get '/login', to: 'users#login'
  get 'check' => 'article#checkUser'
  root 'article#index'

  mount ApplicationApi => '/api'
  mount GrapeSwaggerRails::Engine => '/apidoc'
end
