class Admin::ArticlesController < Admin::BaseController
  before_action :set_article, only: [:show, :edit, :destroy,:update]
  def index
    @articles = Article.all
  end

  def show

  end

  def update
    @article.update(raticles_params)
    redirect_to admin_article_url(params[:id]),notice: "文章更新成功！"
  end

  def edit
  end

  def destroy
    @article.destroy
    redirect_to admin_articles_url,notice: "文章删除成功！"
  end

  def create
    a = {
      "title" => raticles_params[:title],
      "content" => raticles_params[:content]
    }
    @article = Article.new(a)
    begin
      @article.transaction do
        @article.user_id = current_user.id
        @article.read = 1
        ActiveRecord::Base.transaction do
          if @article.save
            raticles_params[:tags].split(',').each do |tag|
              @article.tags << Tag.find_or_create_by(tag_name: tag)
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
      params.require(:article).permit(:title,:content,:tags)
    end

    def set_article
      @article = Article.friendly.find(params[:id])
    end
end
