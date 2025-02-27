class Admin::CoursesController < Admin::BaseController
  def index
    @courses = Course.includes(units: [ :topics ])
    render  partial: "admin/courses/index"
  end

  def show
    @course = Course.find(params[:id])
  end
end
