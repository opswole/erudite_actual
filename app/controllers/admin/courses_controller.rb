class Admin::CoursesController < ApplicationController
  # Force elevated privileges
  include Authorisation

  def index
  end
end
