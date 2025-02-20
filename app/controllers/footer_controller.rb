class FooterController < ApplicationController
  def show
    # TODO - fix this because brakeman complains
    render params[:page]
  end
end
