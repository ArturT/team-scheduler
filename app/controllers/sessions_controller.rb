class SessionsController < ApplicationController
  skip_before_filter :authenticated

  def create
    if auth_hash
      domain = auth_hash.info.email.split("@")[1]
      company = Company.find_by_domain(domain)
      if company
        session[:authenticated] = true
        flash[:success] = "Successfully logged into the " + company.name + " account"
        redirect_to boards_path
      else
        flash[:error] = "Cannot login with this Google account"
        redirect_to root_path
      end
    else
      flash[:error] = "You must be logged in to view this page"
      redirect_to root_path
    end
  end

  def failure
    flash[:error] = "You must be logged in to view this page"
    redirect_to root_path
  end

  def logout
    session[:authenticated] = false
    flash[:success] = "You have logged out"
    redirect_to root_path
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end