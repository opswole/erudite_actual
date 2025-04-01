class User::TimetablesController < ApplicationController
  before_action :redirect_to_dashboard_unless_turbo_frame, only: :index
  def index
    @assignments = Assignment.all

    @assignments_f = {
      assignments: @assignments.map do |assignment|
        {
          Id: assignment.id,
          Subject: assignment.title || "Assignment #{assignment.id}",
          StartTime: assignment.deadline.to_time.iso8601,
          EndTime: assignment.deadline.to_time.iso8601,
          CategoryColor: "#1aaa55"
        }
      end
    }.to_json
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
