class TopicsController < ApplicationController
  before_action :set_topic, only: [ :show, :update, :destroy ]

  def index
  end

  def show
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
  def set_unit
    @unit = @topic.unit
  end

  def topic_params
    params.require(:topic).permit(:title, :description, :unit_id, files: [])
  end
end
