class TagController < ApplicationController
  def index
    @tag = params[:tag_name]
    @articles_all = Tag.includes(:articles).includes(:tag_article_relationships).find_by(tag_name: params[:tag_name]).articles
    @articles = @articles_all.order(id: :desc).page(params[:page]).per(5)
    @tags = Tag.includes(:articles).includes(:tag_article_relationships).order(id: :desc)
    @tags_list = Tag.find_by_sql('SELECT T.ID,T.tag_name, f.COUNT  FROM ( SELECT tags.ID, COUNT ( tag_name ) FROM tags JOIN tag_article_relationships ON tags.ID = tag_article_relationships.tag_id GROUP BY tags.ID ) f JOIN tags T ON T.ID = f.ID')
  end
end
