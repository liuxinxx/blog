class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:show, :edit, :destroy,:update]
  before_action :set_article_is_is_original, only: [:create, :update]
  def index
    @articles = Article.all.order(id: :desc).page(params[:page]).per(10)
  end

  def show

  end

  def update
    ord_tags = @article.tags.ids
    @article.update(
       title:raticles_params[:title],
       content:raticles_params[:content],
       source_title:raticles_params[:source_title],
       source_url:raticles_params[:source_url],
       is_original:@is_original
       )
    # 删除当前关联
    @article.tags.delete_all
    raticles_params[:tags].split(',').each do |t|
      tag = Tag.find_by(tag_name: t)
      unless tag.present? && TagArticleRelationship.find_by(article_id: @article.id,tag_id:tag.id)
        @article.tags << Tag.find_or_create_by(tag_name: t)
      end
    end

    ord_tags.each do |tag|
      articles = Tag.find_by_id(tag).articles.count
      if articles == 0
        Tag.find_by_id(tag).delete
      end
    end
    redirect_to article_url(params[:id]),notice: "文章更新成功！"
  end

  def edit
    @tags = ''
    if @article.tags.present?
      @article.tags.each do|t|
        @tags+=t.tag_name+','
      end
    end

  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url,notice: "文章删除成功！"
  end

  def create
    a = {
      "title" => raticles_params[:title],
      "content" => raticles_params[:content],
      "source_title"=> raticles_params[:source_title],
      "source_url"=> raticles_params[:source_url],
      "is_original"=> @is_original
    }
    @article = Article.new(a)
    begin
      @article.transaction do
        @article.user_id = current_user.id
        @article.read = 1
        ActiveRecord::Base.transaction do
          if @article.save
            raticles_params[:tags].split(',').each do |t|
              tag = Tag.find_by(tag_name: t)
              p tag
              if tag.present? && TagArticleRelationship.find_by(article_id: @article.id,tag_id:tag.id)
                p '已存在'
              else
                @article.tags << Tag.find_or_create_by(tag_name: t)
              end
            end
            redirect_to admin_article_url(@article.id) ,notice: "文章创建成功！"
          else
            redirect_to new_admin_article_path ,alert: "发表失败!" << @articles.errors.full_messages.to_s
          end
        end
      end
    rescue Exception => e
      redirect_to new_admin_article_path ,alert: "发表失败!" + e.message
    end
  end

  def new
    @article = Article.new
  end

  private
  def raticles_params
    params.require(:article).permit(:title,:content,:tags,:source_title, :source_url)
  end

  def set_article
    @article = Article.friendly.includes(:tags).find(params[:id])
  end

  def set_article_is_is_original
    @is_original = true
    if raticles_params[:source_title]!="liuxin's blog" || raticles_params[:source_url].present?
      @is_original = false
    end
  end
end
