class FooterController < ApplicationController
  ALLOWED_PAGES = %w[accessibility contact privacy sitemap terms].freeze

  def show
    page = footer_params[:page]
    if ALLOWED_PAGES.include?(page)
      render page
    else
      render plain: "Page not found", status: :not_found
    end
  end

  private

  def footer_params
    params.permit(:page)
  end
end
