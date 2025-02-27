class User::TopicsController < ApplicationController
  def index
  end

  def show
    @topic = Topic.find(params[:id])
  end
end
