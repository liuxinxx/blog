module V1
  class ArticlesApi < Grape::API
    namespace :articles do

      params do
        requires :title, type: String
      end
      get 'search' do
        list = Article.all.first
        {
          result: 1,
          message: list
        }
      end

      desc 'Create a list.'
      params do
        requires :content, type: String
        requires :catalog_id, type: Integer
      end
      post do
        Article.create!({
          content: params[:content],
          catalog_id: params[:catalog_id]
        })
      end

      desc 'Updates.'
      params do
        requires :id, type: Integer
        requires :content, type: String
      end
      put ':id' do
        if Article.find_by(id: params[:id]).present?
          Article.find(params[:id]).update_attributes(content: params[:content])
          {
            result: 1,
            message: Article.find(params[:id])
          }
        else
          {
            result: 0,
            message: '请联系管理员'
          }
        end
      end

      desc "Delete."
      params  do
        requires :id ,type: Integer
      end

      delete ':id' do
        if Article.find_by(id: params[:id]).present?
          {
            result:1,
            message:'yes'
          }
        else
          {
            result:0,
            message:'no'
          }
        end
      end

    end
  end
end