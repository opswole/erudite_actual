class User::ProfilesController < ApplicationController
  def show
    @user = Current.user
    @course = Course.where(id: @user.course&.id).includes(units: :topics).first
  end
end
