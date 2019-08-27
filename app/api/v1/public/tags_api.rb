module V1
  module Public
    class TagsApi < Grape::API
      namespace :tags do

        desc "文章列表页面"
        params do
          requires :paginate, type: Boolean
        end
        paginate per_page: 10, max_per_page: 50,enforce_max_per_page: true
        get "" do
          sql_str = 'SELECT T.ID,T.tag_name, f.COUNT  FROM ( SELECT tags.ID, COUNT ( tag_name ) FROM tags JOIN tag_article_relationships ON tags.ID = tag_article_relationships.tag_id GROUP BY tags.ID ) f JOIN tags T ON T.ID = f.ID'
          if(params[:paginate])
          @tags_list = paginate  Tag.find_by_sql(sql_str)

          page = {
            total_page: @tags_list.total_pages,
            per_page: @tags_list.current_per_page
          }
        else
          @tags_list =   Tag.find_by_sql(sql_str)
          page = {}
        end
          return {result:1, message:'success' ,data: @tags_list , page: page}
        end
      end
    end
  end
end