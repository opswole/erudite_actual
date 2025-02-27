class Admin::UsersController < Admin::BaseController
  def index
    @users = User.all
    render partial: "admin/users/index"
  end
end
