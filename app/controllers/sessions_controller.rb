class SessionsController < ApplicationController
  skip_before_filter :authenticated

  def create
    if auth_hash
      domain = auth_hash.info.email.split("@")[1]
      company = Company.find_by_domain(domain)
      if company
        session[:authenticated] = company.name
        flash[:notice] = "Successfully logged into the " + company.name + " account"
        redirect_to board_index_path
      else
        flash[:notice] = "Cannot login with this Google account"
        flash[:notice_class] = "error"
        redirect_to root_path
      end
    else
      flash[:notice] = "You must be logged in to view this page"
      flash[:notice_class] = "error"
      redirect_to root_path
    end
  end

  def failure
    flash[:notice] = "You must be logged in to view this page"
    flash[:notice_class] = "error"
    redirect_to root_path
  end

  def logout
    session[:authenticated] = nil
    flash[:notice] = "You have logged out"
    redirect_to root_path
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end