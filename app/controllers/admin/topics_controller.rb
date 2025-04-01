class Admin::TopicsController < Admin::BaseController
  before_action :set_topic, only: [ :show, :edit, :update ]
  def index
  end

  def show
    @topic = Topic.find(params[:id])
    @taggable_users = User.limit(5)
  end

  def edit
  end

  def update
    if params[:file_deletions].present?
      # @topic.files.where(id: params[:topic][:file_deletions]).each(&:purge)
    end

    puts "OLD: #{@topic.files.count}"
    if @topic.update(topic_params)
      render "edit"
      puts "NEW: #{@topic.files.count}"
    else
      render "edit"
    end
  end

  def remove_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    @topic = Topic.find(params[:topic_id])

    render "edit"
  end

  private
  def set_topic
    @topic = Topic.find(params[:id])
  end
  def topic_params
    topic_params = params.require(:topic).permit(:title, :description, :unit_id, files: [])
  end
end
