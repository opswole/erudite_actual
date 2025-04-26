class TimetablesController < ApplicationController
  def index
    @assignments = Assignment.all

    start_date = params.fetch(:start_date, Date.today).to_date
    @assignments = Assignment.where(
      deadline: start_date.beginning_of_month.beginning_of_week..start_date.end_of_month.end_of_week
    )
  end
end
