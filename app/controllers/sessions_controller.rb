class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate(params[:session][:password])
      check_activation user
    else

      flash[:danger] = t "invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def check_activation user
    if user.activated?
      log_in user
      check_remember user
      redirect_back_or user
    else
      flash[:warning] = t "message"
      redirect_to root_url
    end
  end

  def check_remember user
    params[:session][:remember_me] == Settings.sessions_value ? remember(user) : forget(user)
  end
end
