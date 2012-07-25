class ReportController < ApplicationController
  before_filter :get_company_and_date

  def index
  end

  private
  def get_company_and_date
    @company = Company.find_by_name(session[:authenticated])
    @date = get_date
  end

  def get_date
    # to_s is required if params[:date] is empty
    if params[:date].to_s.date?
      @date = params[:date].to_date
    else
      @date = Date.today
    end
  end
end