module V1
  module Admin
    class Base < V1::Base
      namespace :admin do
        mount V1::Admin::ArticlesApi
        mount V1::Admin::TagsApi
      end
    end
  end 
end