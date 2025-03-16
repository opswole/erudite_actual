class Admin::DashboardController < Admin::BaseController
  def index
  end

  def overview
    @users = User.all
    @courses = Course.all
    @units =  Unit.all
    @topics = Topic.all
    render partial: "admin/dashboard/overview"
  end

  def turbo_test
    render "turbo"
  end
end
