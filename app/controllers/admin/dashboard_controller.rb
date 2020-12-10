class Admin::DashboardController < Admin::BaseController
  def index
    authorize! :read, :dashboard
  end
end
