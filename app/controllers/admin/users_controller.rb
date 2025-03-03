class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[edit]
  def index
    @users = User.all
    render partial: "admin/users/index"
  end

  def show
    @user = User.find(params[:id])
  end
  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def user_params
      params.expect(user: [ :first_name, :last_name, :email ])
    end
  def set_user
    @user = User.find(params[:id])
  end
end
