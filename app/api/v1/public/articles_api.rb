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
            per_page: @articles.current_per_page
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

      end
    end
  end
end