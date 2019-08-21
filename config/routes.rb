Rails.application.routes.draw do

  resources :tag do
    collection do
      get :tag_name
    end
  end
  namespace :admin do
    resources :articles , :id => /.*/ 
    root 'articles#index'
  end
  resources :article , :id => /.*/ do
    collection do
      # get '/:id' => 'article#show', :as => :category, :article => { :id => /[\w+\.]+/ }
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
