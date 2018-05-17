class Admin::BaseController < ApplicationController
  before_action :logged_in_user
  private
    def logged_in_user
      unless logged_in?
        redirect_to article_index_url
      end
    end
end