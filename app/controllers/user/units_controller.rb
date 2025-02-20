class User::UnitsController < ApplicationController
  def index
    @units = Unit.all
  end

  def all
    @units = Unit.all
  end

  def show
    @unit = Unit.find(params[:id])
  end

  def edit
    @unit = Unit.find(params[:id])
  end
end
