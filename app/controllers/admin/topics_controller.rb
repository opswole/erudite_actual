class Admin::TopicsController < ApplicationController
  before_action :set_unit
  before_action :set_course
  before_action :set_topic, only: [ :show, :edit, :update, :destroy ]

  def new
    @topic = @unit.topics.build
  end
  def show
  end
  def edit
  end
  def create
    @topic = @unit.topics.build(topic_params)
    if @topic.save
      redirect_to admin_course_path(@unit.course.id), notice: "Topic created successfully"
    else
      render :new
    end
  end

  def update
    if @topic.update(topic_params)
      redirect_to admin_course_path(@unit.course.id), notice: "Unit updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @topic.destroy
    redirect_to admin_course_path(@unit.course.id), notice: "Unit deleted successfully"
  end

  private

  def set_topic
    @topic = Topic.find(params[:id])
  end
  def set_unit
    @unit = Unit.find(params[:unit_id])
  end
  def set_course
    @course = @unit.course
  end

  def topic_params
    params.require(:topic).permit(:title, :description, :unit_id, files: [])
  end
end
