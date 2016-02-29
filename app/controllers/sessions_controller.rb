class SessionsController < ApplicationController

  def new
    redirect_to '/auth/github'
  end

  def create
    auth = request.env["omniauth.auth"]

    get_user = User.where(:provider => auth['provider'],
                      :uid => auth['uid'].to_s).first

    if get_user.blank?
      user = User.create_with_omniauth(auth)
      
      sign_in(user)

      redirect_to "/?registered=true", :notice => "Welcome new member! If you didn't have a profile, we're pulling in your data now!"
      return

    else
      user = get_user
      sign_in(user)

      redirect_to root_url, :notice => "Welcome back!"
    end

  end

  def destroy
    
    sign_out

    redirect_to root_url, :notice => 'Signed out!'
  end

  def failure
    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
  end

end
