class BoardController < ApplicationController
  def index
    @company = Company.find_by_name(session[:authenticated])

    # to_s is required if params[:date] is empty
    if params[:date].to_s.date?
      @date = params[:date].to_date
    else
      @date = Date.today
    end

    @dates = @date.beginning_of_month..@date.end_of_month
  end
end