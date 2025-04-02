class User::AssignmentsController < ApplicationController
  before_action :set_unit
  def index
    @assignments = @unit.assignments
  end

  private
  def set_unit
    @unit = Unit.find(params[:unit_id])
  end
end
