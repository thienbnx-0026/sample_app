class SessionsController < ApplicationController
  protect_from_forgery with: :exception
  include SessionsHelper

  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase

    if user&.authenticate params[:session][:password]
      log_in user
      redirect_to user
    else
      flash[:danger] = t "Invalid email/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
