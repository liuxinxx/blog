module SessionsHelper
  def log_in(user)
    session[:user_address] = user.address
  end

  def current_user
    @current_user ||= User.find_by(address: session[:user_address])
  end

  def logged_in?
    !current_user.nil?
  end

  def log_out
    session.delete(:user_address)
    @current_user = nil
  end
end


