class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    redirect_to login_path unless logged_in?
  end
end
