class User::UnitsController < ApplicationController
  def index
    @units = Current.user.units
  end

  def show
    @unit = Unit.find(params[:id])
    @selected_topic = @unit.topics.find_by(id: params[:topic_id])

    @taggable_users = User
                        .joins(:topics)
                        .where(topics: { id: params[:topic_id] })
                        .where(account_type: %w[student teacher administrator])
                        .where(taggable_by_students: true)
                        .distinct
                        .sort_by(&:account_type)
                        .reverse
  end

  private
  def set_unit
    @unit = Unit.find(params[:id])
  end
  def set_topic
    @topic = Topic.find(params[:topic_id])
  end
end
