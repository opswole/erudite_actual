class User::HomeController < ApplicationController
  def index
    @user = Current.user
  end
end
