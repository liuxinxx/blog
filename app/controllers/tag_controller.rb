class TagController < ApplicationController
  def index
    @tag = params[:tag_name]
    @articles = Tag.find_by(tag_name: params[:tag_name]).articles.order(id: :desc).page(params[:page]).per(5)
    @tags = Tag.all.order(id: :desc)
  end
end
