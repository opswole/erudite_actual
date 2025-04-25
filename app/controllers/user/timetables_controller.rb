class User::TimetablesController < ApplicationController
  before_action :redirect_to_dashboard_unless_turbo_frame, only: :index
  def index
    @assignments = Assignment.all

    start_date = params.fetch(:start_date, Date.today).to_date
    @assignments = Assignment.where(
      deadline: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    )
  end

  def show
  end

  private
  def redirect_to_dashboard_unless_turbo_frame
    # Check if the request comes from a Turbo Frame
    unless request.headers["Turbo-Frame"].present?
      # Redirect to the parent page (e.g., user dashboard) with a parameter to activate the timetable tab
      redirect_to user_overviews_path(tab: "timetable") and return
    end
  end
end
