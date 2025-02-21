class Admin::UsersController < ApplicationController
  def index
    @users = User.all
    render partial: "admin/users/index"
  end
end
