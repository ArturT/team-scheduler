class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticated

  def authenticated
    unless session[:authenticated]
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end
end
