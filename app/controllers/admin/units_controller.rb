class Admin::UnitsController < ApplicationController
  def index
    @units = Unit.includes(:topics)
  end

  def show
    @unit = Unit.find(params[:id])
  end
end
