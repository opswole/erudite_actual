class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :update ]
  def show
    @user = Current.user
    @course = Course.where(id: @user.course&.id).includes(units: :topics).first
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    end
  end

  private
  def user_params
    params.expect(user: [ :taggable_by_students ])
  end

  def set_user
    @user = Current.user
  end
end
