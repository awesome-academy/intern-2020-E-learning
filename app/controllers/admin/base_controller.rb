class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout "admin"

  private

  def check_admin
    return if current_user&.admin?

    flash[:danger] = t "message.require_permission"
    redirect_to root_path
  end
end
