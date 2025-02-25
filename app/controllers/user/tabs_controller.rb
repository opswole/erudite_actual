class User::TabsController < ApplicationController
  def index
    @units = Current.user.units

    @fake_messages = @units.map do |unit|
      Faker::Lorem.sentence(word_count: 10)
    end
  end

  def units
    @units  = Current.user.units
  end

  def messages
  end

  def timetable
  end
end
