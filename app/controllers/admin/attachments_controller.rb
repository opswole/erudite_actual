class Admin::AttachmentsController < Admin::BaseController
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge

    redirect_back(fallback_location: root_path)
  end

  private
end
