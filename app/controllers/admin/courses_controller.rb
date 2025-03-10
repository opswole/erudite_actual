class Admin::CoursesController < ApplicationController
  before_action :set_course, only: %i[ show edit update destroy ]

  def index
    @courses = Course.all.includes(units: :topics)
  end
  def new
    @course = Course.new
  end

  def show
    @course = Course.where(id: @course.id).includes(units: :topics).first
  end
  def edit
    @course = Course.find(params[:id])
  end

  def create
    @course = Course.new(course_params)

    if @course.save
      redirect_to admin_courses_path, notice: "Course was successfully created."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def update
    if @course.update(course_params)
      flash.now[:success] = "Course was successfully updated."
      redirect_to admin_courses_path, notice: "Course was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @course.destroy
    redirect_to admin_users_url, notice: "Course was successfully destroyed."
  end

  private
  def course_params
  params.require(:course).permit(
    :title,
    :owner,
    )
end
def set_course
  @course = Current.user.course
end
end
