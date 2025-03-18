class User::UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def all
    @units = Unit.all
  end

  def show
    @unit = Unit.find(params[:id])
    @selected_topic = @unit.topics.find_by(id: params[:topic_id]) || @unit.topics.first
    @taggable_users = User.limit(5)
  end

  def edit
    @unit = Unit.find(params[:id])
  end
end
