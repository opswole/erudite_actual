class NotificationsController < ApplicationController
  def index
    @mentions = Mention
                  .where(user_id: Current.user.id)
                  .includes(message: { messageable: :unit }, user: {})
                  .order(created_at: :desc)
                  .limit(15).order(created_at: :desc)
    @mentioned_messages = Mention
                            .where(user_id: Current.user.id)
                            .includes(message: { messageable: :unit }, user: {})
                            .order(created_at: :desc)
                            .limit(15).order(created_at: :desc)

    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "notifications",
          partial: "notifications/mentions",
          locals: { mentions: @mentions }
        )
      end
    end
  end

  def new
  end
end
