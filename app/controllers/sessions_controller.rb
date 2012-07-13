class SessionsController < ApplicationController
  def create
    if auth_hash
      domain = auth_hash.info.email.split("@")[1]
      company = Company.find_by_domain(domain)
      if company
        session[:authenticated] = true
        flash[:notice] = "Successfully logged into the " + company.name + " account"
        redirect_to boards_path
      else
        flash[:notice] = "Cannot login with this Google Account"
        flash[:notice_class] = "error"
        redirect_to root_path
      end
    end
  end

  private
  def auth_hash
    request.env["omniauth.auth"]
  end
end