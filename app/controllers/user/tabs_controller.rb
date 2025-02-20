class User::TabsController < ApplicationController
  def overview
  end

  def units
    @units  = Unit.all
  end

  def messages
  end

  def timetable
  end
end
