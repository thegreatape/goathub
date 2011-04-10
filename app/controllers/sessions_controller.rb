class SessionsController < ApplicationController
  skip_before_filter :authorize, {:only => [:new, :create]}

  def new
  end

  def create
    if user = User.authenticate(params[:email], params[:password])
      session[:user_id] = user.id
      redirect_to user.news_feed
    else
      redirect_to login_url, :alert => "Invalid username/password combination"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

end
