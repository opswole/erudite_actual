class User::NotificationsController < ApplicationController
  def index
    @mentions = Current.user.mentions.includes(:message).order(created_at: :desc)
    @mentioned_messages = Current.user.mentioned_messages.order(created_at: :desc)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "notifications",
          partial: "user/notifications/mentions",
          locals: { mentions: @mentions }
        )
      end
    end
  end

  def new
  end
end
