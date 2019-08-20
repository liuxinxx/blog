module V1
  module Admin
    class TagsApi < Grape::API
      namespace :tags do
        desc 'Create a list.'
        params do
          requires :name, type: String
        end
        post do
          if Tag.find_by(tag_name: params[:name]).present?
            {
              result: 1,
              message: "标签已存在",
              data: Tag.find(params[:name])
            }
          else
            new_tag = {
              "tag_name" => params[:name]
            }
            @tag = Tag.new(new_tag)
            ActiveRecord::Base.transaction do
              if @tag.save
                return {result: 1,message:"创建成功",data: @tag}
              else
                return {result: 0,message:"创建失败!error_message:" << @tag.errors.full_messages.to_s }
              end
            end
          end
        end

        desc 'Create a list.'
        params do
          requires :name, type: String
        end
        get "/find_by_name"do
          p params
          tag = Tag.find_by(tag_name: params[:name])
          if tag.present?
            {
              result: 1,
              message: "标签已存在",
              data: tag
            }
          else
            {
              result: 0,
              message: "不存在",
              data: nil
            }
          end
        end

      

        desc "删除标签"

        delete ":id" do
          @tag = Tag.find_by_id(params[:id])
          return {result:0, message: "数据不存在",data: nil } unless @tag.present?

          begin
            ActiveRecord::Base.transaction do
              @tag.destroy
            end
            return {result:1, message: "删除成功",data: nil }
          rescue Exception => e
            return {result:1, message: "删除失败",data: e.message }
          end
        end

        desc "标签页列表"
        paginate per_page: 10, max_per_page: 50,enforce_max_per_page: true
        get "" do
          @tags = paginate  Tag.all
           page = {
            total_page: @tags.total_pages,
            per_page: @tags.current_per_page
          }
          return {result:1, message:'success' ,data: @tags , page: page}

        end

      end
    end
  end
end