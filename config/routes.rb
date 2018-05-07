Rails.application.routes.draw do
  get 'dome/index'

  get 'dome/show'
  root 'dome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
