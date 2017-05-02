class SessionController < ApplicationController
  def new
  end

  def create
    self.current_user = User.from_omniauth(request.env['omniauth.auth'])

    if current_user
      redirect_to homes_path
    else
      redirect_to auth_path(provider: 'github')
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def failure
    flash[:notice] = "Login Failure to nextChapter"

    redirect_to root_path
  end
end
