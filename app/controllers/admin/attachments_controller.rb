class Admin::AttachmentsController < Admin::BaseController
  def destroy
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @topic = Topic.find(params[:topic_id])
    @attachment.purge

    redirect_to admin_topic_path(@topic)
  end

  private
end
