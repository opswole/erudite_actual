class Admin::DashboardController < Admin::BaseController
  def index
  end

  def overview
    @courses = Course.all
    @users = User.all
    render partial: "admin/dashboard/overview"
  end
end
