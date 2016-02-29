module SessionsHelper

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= User.find_by_remember_token(session[:remember_token])
  end

  # def correct_user?
  #   @user = User.find(params[:id])
  #   unless current_user == @user
  #     redirect_to root_url, :alert => "Access denied."
  #   end
  # end

  # def authenticate_user!
  #   if !current_user
  #     redirect_to root_url, :alert => 'You need to sign in for access to this page.'
  #   end
  # end

  def sign_in(user)
    session[:remember_token] = user.remember_token
  end

  def sign_out
    session.delete(:remember_token)
  end 
  
end