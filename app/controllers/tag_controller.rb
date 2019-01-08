class TagController < ApplicationController
  def index
    @tag = params[:tag_name]
    @articles_all = Tag.includes(:articles).includes(:tag_article_relationships).find_by(tag_name: params[:tag_name]).articles
    @articles = @articles_all.order(id: :desc).page(params[:page]).per(5)
    @tags = Tag.includes(:articles).includes(:tag_article_relationships).order(id: :desc)
  end
end
