class FooterController < ApplicationController
  def show
    render params[:page]
  end
end
