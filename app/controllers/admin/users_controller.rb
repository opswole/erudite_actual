class Admin::UsersController < Admin::BaseController
  before_action :set_user, only: %i[ show edit update destroy ]
  def index
  end
  def list
    @users = User.all
  end
  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @course = Course.where(id: @user.course&.id).includes(units: :topics).first
  end
  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      create_enrollment if params[:user][:course_id].present?

      redirect_to admin_users_path, notice: "User was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      flash.now[:success] = "User was successfully updated."
      redirect_to admin_users_path, notice: "User was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_url, notice: "User was successfully destroyed."
  end

  private
    def user_params
      params.require(:user).permit(
        :first_name,
        :last_name,
        :email_address,
        :password,
        :password_confirmation,
        :account_type,
        )
    end
  def set_user
    @user = User.find(params[:id])
  end

  def create_enrollment
    enrollment = @user.create_enrollment(course_id: params[:user][:course_id])
    unless enrollment.persisted?
      @user.errors.add(:base, "Failed to create enrollment: #{enrollment.errors.full_messages.join(', ')}")
      raise ActiveRecord::Rollback
    end
  end
end
