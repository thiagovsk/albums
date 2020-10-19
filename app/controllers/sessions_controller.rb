class SessionsController < ApplicationController
  before_action :authorize, except: %i[new create]

  def new; end

  def create
    if user&.authenticate(params[:login][:password])
      session[:user_id] = user.id.to_s
      redirect_to root_path, notice: 'Successfully logged in!'
    else
      flash.now.alert = "Sorry, we couldn't find an account with this username."\
                         " Please check you're using the right username and try again."
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to login_path, notice: 'Logged out!'
  end

  private

  def user
    @user ||= User.find_by(username: params[:login][:username])
  end
end
