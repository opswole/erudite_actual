class CoursesController < ApplicationController
  :allow_unauthenticated_access
  def index
    @courses = Course.all
  end
end
