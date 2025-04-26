class HomeController < ApplicationController
  def index
    @user = Current.user
  end
end
