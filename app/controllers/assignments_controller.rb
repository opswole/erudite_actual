class AssignmentsController < ApplicationController
  before_action :set_assignment, only: %i[show edit update destroy]
  before_action :set_unit, only: %i[ new ]

  # GET /assignments or /assignments.json
  def index
    @assignments = Assignment.all
  end

  # GET /assignments/1 or /assignments/1.json
  def show
    @taggable_users = User
                        .joins(:enrollment)
                        .where(enrollments: { course_id: Current.user.course.id })

    @unit_title = Unit.find(@assignment.unit_id).title
  end

  # GET /assignments/new
  def new
    @assignment = Assignment.new
  end

  # GET /assignments/1/edit
  def edit
    @deadline = Date.parse(@assignment.deadline)
  end

  # POST /assignments or /assignments.json
  def create
    @assignment = Assignment.new(assignment_params)
    set_deadline_with_time if assignment_params[:deadline].present?

    respond_to do |format|
      if @assignment.save
        format.html { redirect_to @assignment, notice: "Assignment was successfully created." }
        format.json { render :show, status: :created, location: @assignment }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /assignments/1 or /assignments/1.json
  def update
    set_deadline_with_time if assignment_params[:deadline].present?

    respond_to do |format|
      if @assignment.update(assignment_params)
        format.html { redirect_to @assignment, notice: "Assignment was successfully updated." }
        format.json { render :show, status: :ok, location: @assignment }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @assignment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /assignments/1 or /assignments/1.json
  def destroy
    @assignment.destroy!

    respond_to do |format|
      format.html { redirect_to assignments_path, status: :see_other, notice: "Assignment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def remove_attachment
    @attachment = ActiveStorage::Attachment.find(params[:id])
    @attachment.purge
    @assignment = Assignment.find(params.expect(:assignment_id))
    @unit = @assignment.unit

    render "edit", locals: { assignment: @assignment, unit: @unit }
  end

  private

  def set_assignment
    @assignment = Assignment.find(params.expect(:id))
  end

  def set_unit
    @unit = Unit.find(params.expect(:unit_id))
  end

  def assignment_params
    params.expect(assignment: [ :title, :description, :deadline, :unit_id, files: [] ])
  end

  def set_deadline_with_time
    date_str = assignment_params[:deadline]
    time = Time.current
    is_bst = time.dst?
    full_date_str = "#{date_str}T18:00:00#{is_bst ? '+01:00' : '+00:00'}"
    @assignment.deadline = DateTime.parse(full_date_str)
  end
end
