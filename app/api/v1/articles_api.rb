module V1
  class ArticlesApi < Grape::API
    namespace :articles do

      desc 'Create a list.'
      params do
        requires :title, type: String
        requires :content, type: String
        requires :tags, type: String
        requires :source_title, type: String
      end
      post do
        pp params
        is_original = true
        is_original = false if params[:source_title]!="liuxin's blog"
        is_original = false if params[:source_url] != ""

        a = {
          "title" => params[:title],
          "content" => params[:content],
          "source_title"=> params[:source_title],
          "source_url"=> params[:source_url],
          "is_original"=> is_original
        }
        @article = Article.new(a)
        begin
          @article.transaction do
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
                return {result: 1,message:"文章创建成功！"}
              else
                return {result: 0,message:"发表失败!error_message:" << @articles.errors.full_messages.to_s }
              end
            end
          end
        rescue Exception => e
          return {result: 0,message:"发表失败!error_message:" << e.message }
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