class SessionsController < ApplicationController
  include SessionsHelper

  def new
    session[:return_to] = request.referer
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user&.authenticate(params[:session][:password])
      log_in user
      redirect_by_role
    else
      flash.now[:danger] = t "message.user.login_fail"
      render :new
    end
  end
end
