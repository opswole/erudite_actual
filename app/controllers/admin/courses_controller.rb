class Admin::CoursesController < ApplicationController
  def index
    @courses = Course.includes(units: [ :topics ])
  end

  def show
    @course = Course.find(params[:id])
  end
end
