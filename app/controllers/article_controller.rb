class ArticleController < ApplicationController
  include SessionsHelper
  def index
  end

  def show
  end

  def new
  end

  def edit
  end

  def checkUser
    if params[:user].present?
      Rails.logger.info "login user ==== #{params[:user]}"
      user = User.where(address: params[:user].to_s)
      Rails.logger.info "user ? ==#{user}"
      if user.count > 0
        if @current_user.present?
          if @current_user.address == params[:user].to_s
            render json:{'message'=>'ok',"result" => 1}
            # redirect_to blocks_url
          else
            log_out
            log_in user.first
            render json:{'message'=>'ok',"result" => 1}
            # redirect_to blocks_url
          end
        else
          log_in user.first
          render json:{'message'=>'Login successful!',"result" => 1}
          # redirect_to blocks_url
        end
      else
        respond_to do |format|
          format.html
          format.js {}
          format.json {
            render json: {'message'=>'error',result:0}
          }
        end
      end
    end
  end
end
