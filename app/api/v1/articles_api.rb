module V1
  class ArticlesApi < Grape::API
    namespace :articles do

      desc 'Create a list.'
      params do
        requires :title, type: String
        requires :content, type: String
        requires :tags, type: String
      end
      post do
        a = {
          "title" => params[:title],
          "content" => params[:content]
        }
        @article = Article.new(a)
        begin
          @article.user_id = current_user.id
          @article.read = 1
          ActiveRecord::Base.transaction do
            if @article.save
              params[:tags].split(',').each do |t|
                tag = Tag.find_by(tag_name: t)
                p tag
                if tag.present? && TagArticleRelationship.find_by(article_id: @article.id,tag_id:tag.id)
                  p '已存在'
                else
                  @article.tags << Tag.find_or_create_by(tag_name: t)
                end
              end
              return {result: 1,message: 'success' ,data: @article}
            else
              return {result: 0,message: 'fail'+ @articles.errors.full_messages.to_s ,data: nil}
            end
          end
        rescue Exception => e
          return {result: 0,message: 'fail'+e.message,data: nil}
        end
      end

      desc 'Updates.'
      params do
        requires :id, type: Integer
        requires :content, type: String
        requires :tags, type: String
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

    end
  end
end