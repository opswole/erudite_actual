class Admin::UnitsController < Admin::BaseController
  def index
    @units = Unit.includes(:topics)
  end

  def show
    @course = Course.find(params[:course_id])
    @unit = Unit.find(params[:id])
  end
end
