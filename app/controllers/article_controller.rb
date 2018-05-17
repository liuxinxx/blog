class ArticleController < ApplicationController
  include SessionsHelper
  def index
  end

  def show
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
end
