class MentionsController < ApplicationController
  before_action :set_mention, only: %i[ show edit update destroy ]

  # GET /mentions or /mentions.json
  def index
    @mentions = Mention
                  .where(user_id: current_user.id)
                  .includes(message: { messageable: :unit }, user: {})
                  .order(created_at: :desc)
                  .limit(15)
  end

  # GET /mentions/1 or /mentions/1.json
  def show
  end

  # GET /mentions/new
  def new
    @mention = Mention.new
  end

  # GET /mentions/1/edit
  def edit
  end

  # POST /mentions or /mentions.json
  def create
    @mention = Mention.new(mention_params)

    respond_to do |format|
      if @mention.save
        format.html { redirect_to @mention, notice: "Mention was successfully created." }
        format.json { render :show, status: :created, location: @mention }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mentions/1 or /mentions/1.json
  def update
    respond_to do |format|
      if @mention.update(mention_params)
        format.html { redirect_to @mention, notice: "Mention was successfully updated." }
        format.json { render :show, status: :ok, location: @mention }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @mention.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mentions/1 or /mentions/1.json
  def destroy
    @mention.destroy!

    respond_to do |format|
      format.html { redirect_to mentions_path, status: :see_other, notice: "Mention was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mention
      @mention = Mention.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def mention_params
      params.expect(mention: [ :user_id, :message_id ])
    end
end
