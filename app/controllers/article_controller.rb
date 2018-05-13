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
      if User.where(address: params[:user].to_s).count > 0
        if @current_user.present?
          if @current_user.address == params[:user].to_s
            render json:{'message'=>'ok',"result" => 1}
            # redirect_to blocks_url
          else
            log_out
            log_in User.where(address: params[:user].to_s).first
            render json:{'message'=>'ok',"result" => 1}
            # redirect_to blocks_url
          end
        else
          log_in User.where(address: params[:user].to_s).first
          render json:{'message'=>'Login successful!',"result" => 1}
          # redirect_to blocks_url
        end
      else
        respond_to do |format|
          format.html
          format.js {}
          format.json {
            render json: {result:0}
          }
        end
      end
    end
  end
end
