class Admin::MessagesController < Admin::BaseController
  before_action :set_topic
  def index
  end

  def new
    @message = @topic.messages.build
  end

  def create
    @message = @topic.messages.build(message_params)
    @message.user = Current.user

    if @message.save
      redirect_to @topic, notice: "Message posted successfully."
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
    params.require(:message).permit(:content, :topic_id)
  end
end
