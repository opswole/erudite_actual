class Admin::OverviewsController < Admin::BaseController
  def index
    @users = User.all
    @courses = Course.all
    @units = Unit.all
    @topics = Topic.all

    @user_audits =  Audited::Audit.where(auditable_type: "User").order(created_at: :desc)
    end
end
