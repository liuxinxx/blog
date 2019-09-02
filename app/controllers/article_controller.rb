class ArticleController < ApplicationController
  include SessionsHelper
  before_action :set_article, only: [:show]
  before_action :set_tags, only: [:index,:show,:search]

  def index
    @page_keywords = ''
    Tag.all.each do |c|
      @page_keywords += "#{c.tag_name},"
    end
    fresh_when  @articles = Article.all.includes(:tags).order(id: :desc).page(params[:page]).per(5)
  end

  def show
    @page_title       = @article.title
    @page_description = @article.content.split('<!--more-->')[0].gsub('##','####').gsub(/^#.*?\s+/,'#### ')
    @page_keywords = ''
    @article.tags.each do |c|
      @page_keywords += "#{c.tag_name},"
    end
    fresh_when @article.update!(read: @article.read+=1)
  end

  def checkUser
    if params[:user].present?
      Rails.logger.info "login user ==== #{params[:user]}"
      user = User.where(address: params[:user].to_s)
      Rails.logger.info "user ? ==#{user.count}"
      if user.count > 0
        if current_user.present?
          if current_user.address.to_s == params[:user].to_s
            render json:{'message'=>'Logged in!',"result" => 1}
          end
        else
          log_in user.first
          render json:{'message'=>'Login successful!',"result" => 1}
        end
      else
        respond_to do |format|
          log_out
          format.html {redirect_to article_index_url}
          format.js {}
          format.json {
            render json: {'message'=>'error',result:0}
          }
        end
      end
    end
  end

  def search
    validate_search_key
    if @query_string.present?
      search_result = Article.ransack(@search_criteria).result(:distinct => true)
      @articles = search_result.page(params[:page]).per(10)
    end
  end

  protected

    def validate_search_key
      @query_string = params[:q].gsub(/\\|\'|\/|\?/, "") if params[:q].present?
      @search_criteria = search_criteria(@query_string)
    end

    def search_criteria(query_string)
      { title_or_content_cont: query_string }
    end

    def set_article
      @article = Article.friendly.includes(:tags).find(params[:id])
    end

    def set_tags
      @tags = Tag.all.includes(:articles).includes(:tag_article_relationships).order(id: :desc)
      @tags_list = Tag.find_by_sql('SELECT T.ID,T.tag_name, f.COUNT  FROM ( SELECT tags.ID, COUNT ( tag_name ) FROM tags JOIN tag_article_relationships ON tags.ID = tag_article_relationships.tag_id GROUP BY tags.ID ) f JOIN tags T ON T.ID = f.ID')
    end
end