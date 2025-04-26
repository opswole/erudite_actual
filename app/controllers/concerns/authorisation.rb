module Authorisation
  extend ActiveSupport::Concern

  included do
    before_action :require_elevated_access
  end

  private
  def elevated_access?
    Current.user&.administrator? || Current.user&.teacher?
  end
  def require_elevated_access
    unless elevated_access?
      flash[:alert] = "This action requires administrator privileges."
      redirect_to root_url, alert: "You shall not pass!"
    end
  end
end
