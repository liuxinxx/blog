module V1
  module Public
    class ArticlesApi < Grape::API
      namespace :articles do

        desc "文章列表页面"
        paginate per_page: 10, max_per_page: 50,enforce_max_per_page: true
        get "" do
          @articles = paginate  Article.all
           page = {
            total_page: @articles.total_pages,
            per_page: @articles.current_per_page,
            tatal_count: @articles.total_count  
          }
          return {result:1, message:'success' ,data: @articles , page: page}
        end

        desc "查询文章是否存在"
        params do
          requires :title, type: String
        end
        get "search" do
          @article = Article.find_by_title(params[:title])
          data = {
            "id" => @article.id,
            "title" => @article.title
          }
          return {result:1, message:'success' ,data: data}
        end


        desc "根据id查询文章"
        get ":id" do
          @article = Article.find_by_id(params[:id])
          if(@article)
            return {result:1, message:'success' ,data: @article}
          else
            return {result:0, message:'文章不存在' ,data: @article}
          end

        end

      end
    end
  end
end