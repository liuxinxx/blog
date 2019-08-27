module V1
  module Public
    class Base < Grape::API
      namespace :public do
         mount ArticlesApi
         mount TagsApi
       end
    end
  end 
end