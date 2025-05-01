class MessagesController < ApplicationController
  def index
    @mentions = Current.user.mentioned_messages.sort_by(&:created_at).reverse

    @users = User.all
    @sorted_users = User.where(account_type: %w[student teacher]).sort_by(&:account_type).reverse
  end

  def new
    @message = @topic.messages.build
  end

  def create
    @message = Message.new(message_params)
    p message_params

    if @message.save!
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_to user_topic_path(@message.topic), notice: "Message created successfully." }
      end
    else
      # render :new, status: :unprocessable_entity
    end
  end

  private
  def message_params
    params.expect(message: [ :title, :content, :messageable_id, :messageable_type, tagged_user_ids: [] ]).with_defaults(user: Current.user)
  end
end
