class Admin::BaseController < ApplicationController
	include SessionsHelper
  include ApplicationHelper
  before_action :logged_in_user
  layout 'admin/application'
  private
    def logged_in_user
      unless logged_in?
        redirect_to article_index_url
      end
    end
end