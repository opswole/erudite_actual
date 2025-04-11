class MessagesController < ApplicationController
  def index
  end

  def new
    @topic = Topic.find(params[:topic_id])
    @message = @topic.messages.build
  end

  def create
    @message = Message.new(message_params)

    if @message.save
      respond_to do |format|
        format.turbo_stream
      end
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_topic
    @topic =  Topic.find(params[:topic_id])
  end

  private
  def message_params
    params.expect(message: [ :title, :content, :messageable_type, :messageable_id ]).with_defaults(user: Current.user)
  end
end
