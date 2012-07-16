class SessionsController < ApplicationController
  skip_before_filter :authenticated

  def create
    domain = get_domain
    company = Company.find_by_domain(domain)
    if company
      session[:authenticated] = company.name
      flash[:success] = "Successfully logged into the " + company.name + " account."
      redirect_to board_index_path
    else
      flash[:error] = "Cannot login with this Google account."
      redirect_to root_path
    end
  end

  def failure
    flash[:error] = "You must be logged in to view this page."
    redirect_to root_path
  end

  def logout
    session[:authenticated] = nil
    flash[:success] = "You have logged out."
    redirect_to root_path
  end

  private
  def get_domain
    request.env["omniauth.auth"].info.email.split("@")[1]
  end
end