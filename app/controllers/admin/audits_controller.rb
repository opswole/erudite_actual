class Admin::AuditsController < Admin::BaseController
  def index
    @user_audits = Audited::Audit.where(auditable_type: "User").order(created_at: :desc)
  end
end
