class HomeController < ApplicationController
  skip_before_filter :authenticated

  def index

  end

  def logout
    session[:authenticated] = false
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end
end
