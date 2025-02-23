class User::TabsController < ApplicationController
  def index
    @units = Unit.all
    # TODO -> When course subcriptions exist for User, make this based on course subscription
    @course = Course.find(1)
    @course.units.includes(:topics)

    @fake_messages = @course.units.map do |unit|
      Faker::Lorem.sentence(word_count: 10)
    end
  end

  def units
    @units  = Unit.all
  end

  def messages
  end

  def timetable
  end
end
