class Admin::BaseController < ApplicationController
  # Force elevated privileges
  include Authorisation
end
