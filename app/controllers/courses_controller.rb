class CoursesController < ApplicationController
  def index
    @course = Course.find_by_id(2)
  end
end
