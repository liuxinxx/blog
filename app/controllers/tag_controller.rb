class TagController < ApplicationController
  def index
    @tag = params[:tag_name]
    @articles = Tag.find_by(tag_name: params[:tag_name]).articles.page(params[:page]).per(15)
  end
end
