class UsersController < ApplicationController
  include SessionsHelper

  def login
  
  end

  def create
    if params[:user].present?
      Rails.logger.info "login user ==== #{params[:user]}"
      user = User.where(address: params[:user][:address].to_s)
      Rails.logger.info "user ? ==#{user.count}"
      if user.count > 0
        if current_user.present?
          if current_user.address.to_s == params[:user].to_s
            respond_to do |format|
              format.html {redirect_to admin_articles_url}
            end
          end
        else
          log_in user.first
          respond_to do |format|
            format.html {redirect_to admin_articles_url}
          end
        end 
      else
        respond_to do |format|
          format.html {redirect_to article_index_url} 
        end
      end
    end
  end
end
