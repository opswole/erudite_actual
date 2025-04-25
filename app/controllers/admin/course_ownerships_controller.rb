class Admin::CourseOwnershipsController < ApplicationController
  before_action :set_current_owners, :set_staff, only: [ :show, :edit, :update, :destroy ]
  before_action :set_course, only: [ :edit, :create ]
  before_action :find_owner_by_email, only: [ :create ]

  def new
    @course_ownership = @course.CourseOwnership.new
  end

  def create
    @course_ownership = @course.course_ownerships.new(user: @owner)

    # TODO: flash this
    if @owner.nil?
      p "OWNER IS NIL"
    elsif @course.owners.include?(@owner)
      p "OWNER ALREADY IS"
    elsif @course_ownership.save
      redirect_to admin_courses_path, notice: "Course ownership was successfully created."
    else
      flash.now[:alert] = "Failed to create course ownership"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    # if @course_ownership.update(course_ownership_params)
    #   redirect_to admin_courses_path, notice: "Course ownership was successfully updated."
    # else
    #   set_staff
    #   render :edit, status: :unprocessable_entity
    # end
  end

  def destroy
    CourseOwnership.find_by(course_id: params[:course_id], user_id: params[:id]).destroy
    redirect_to admin_courses_path, notice: "Course ownership was successfully deleted."
  end

  def show
  end

  private

  def set_current_owners
    @owners= Course.find(params[:course_id]).owners
  end

  def set_course
    @course = Course.find(params[:course_id])
  end

  def set_staff
    @staff = User.where.not(account_type: "student")
  end

  def find_owner_by_email
    @owner = User.find_by(email_address: course_ownership_params[:email_address])
  end
  def course_ownership_params
    params.require(:course_ownership).permit(:email_address)
  end
end
