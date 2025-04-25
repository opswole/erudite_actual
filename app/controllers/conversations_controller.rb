class ConversationsController < ApplicationController
  before_action :set_conversation, only: %i[ show destroy ]
  def index
    @conversations = Current.user.conversations
  end

  def new
    @conversation = Conversation.new
  end

  def create
    @conversation = Conversation.new(conversation_params)

    if @conversation.save
      @conversation.users << Current.user

      if params[:user_id].present?
        @conversation.users << User.find(params[:user_id])
      end

      redirect_to @conversation, notice: "Conversation created successfully!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @conversation.destroy!

    redirect_to conversations_path
  end
  private
  def conversation_params
    params.require(:conversation).permit(:name)
  end
  def set_conversation
    @conversation = Conversation.find(params[:id])
  end
end
