class Admin::BaseController < ApplicationController
  before_action :check_admin
  layout "admin"

  private

  def check_admin
    redirect_to root_path unless get_current_user.admin?
  end
end
