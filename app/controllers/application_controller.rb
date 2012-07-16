class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticated

  def authenticated
    unless session[:authenticated]
      flash[:notice] = "You must be logged in to view this page"
      flash[:notice_class] = "error"
      redirect_to root_path
    end
  end
end
