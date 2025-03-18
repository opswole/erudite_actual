class Admin::TopicsController < Admin::BaseController
  def index
  end

  def show
    @topic = Topic.find(params[:id])
    @taggable_users = User.limit(5)
  end
end
