module V1
  module Public
    class ArticlesApi < Grape::API
      namespace :articles do

        desc "文章列表页面"
        paginate per_page: 10, max_per_page: 50,enforce_max_per_page: true
        get "" do
          @articles = paginate  Article.find_by_sql("SELECT G
                                                    .*,
                                                    u.nickname AS username
                                                  FROM
                                                    (
                                                    SELECT A
                                                      .*,
                                                      string_agg ( tag_name, ',' ) AS tag 
                                                    FROM
                                                      articles
                                                      A INNER JOIN tag_article_relationships t_a ON t_a.article_id = A.
                                                      ID INNER JOIN tags T ON T.ID = t_a.tag_id 
                                                    GROUP BY
                                                      A.ID 
                                                    )
                                                    G INNER JOIN users u ON u.ID = G.user_id");
          @list = @articles.collect do |a|  
            count = a.content.size()
            count =  a.content.index("<!--more-->")
            a.content= a.content[0..count.to_i - 1]
            a
          end
           page = {
            total_page: @articles.total_pages,
            per_page: @articles.current_per_page,
            total_count: @articles.total_count
          }
          return {result:1, message:'success' ,data: @list   , page: page}
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