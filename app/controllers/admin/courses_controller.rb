class Admin::CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  def index
    @courses = Course.all.includes(units: :topics)
  end
  def new
    @course = Course.new
    @course.course_ownerships.new

    @staff = User.where(account_type: "teacher")
  end

  def show
    @course = Course.where(id: @course.id).includes(units: :topics).first
  end

  def edit
    @staff = User.where(account_type: "teacher")
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to edit_admin_course_path(@course), notice: "Course was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      flash.now[:success] = "Course was successfully updated."
      redirect_to admin_courses_path, notice: "Course was successfully updated."
    else
      @staff = User.where(account_type: "teacher")
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_users_url, notice: "Course was successfully destroyed."
  end

  private
  def course_params
    params.require(:course).permit(:title, course_ownerships_attributes: [ :id ])
  end
  def set_course
    @course = Course.find(params[:id])
  end
end
