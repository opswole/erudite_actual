class ErrorsController < ApplicationController
  def access_denied
    render "user/home/index"
  end
end
