class Admin::UnitsController < ApplicationController
  before_action :set_unit, only: [ :show, :edit, :update, :destroy ]

  def new
    @course = Course.find(params[:course_id])
    @unit = @course.units.build
  end

  def show
  end

  def edit
    @course = @unit.course
  end

  def create
    @course  = Course.find(params[:unit][:course_id])
    @unit = @course.units.build(unit_params)

    if @unit.save
      redirect_to admin_course_path(@course), notice: "Unit created successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @unit.update(unit_params)
      redirect_to admin_course_path(@unit.course), notice: "Unit updated successfully"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @unit.destroy
    redirect_to admin_course_path(@unit.course), notice: "Unit deleted successfully"
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_courses_path, alert: "Unit not found"
  end

  private

  def set_unit
    @unit = Unit.find(params[:id])
  end

  def unit_params
    params.require(:unit).permit(:title, :description)
  end
end
