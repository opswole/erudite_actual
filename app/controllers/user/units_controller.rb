class User::UnitsController < ApplicationController
  def index
    @units = Current.user.units
  end

  def show
    @unit = Unit.find(params[:id])
    @selected_topic = @unit.topics.find_by(id: params[:topic_id])

    @notebook = Current.user.notebooks.find_by(notebookable_type: "Unit", notebookable_id: @unit.id)

    @taggable_users = User
                        .joins(:enrollment)
                        .where(enrollments: { course_id: 1 })
  end

  private
  def set_unit
    @unit = Unit.find(params[:id])
  end
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
