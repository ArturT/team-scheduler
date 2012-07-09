class BoardsController < ApplicationController
  def index
    @developers = Developer.includes(:schedules => [:project]).all
    @date = params[:date] ? params[:date].to_date : Date.today
    @dates = @date.beginning_of_month..@date.end_of_month
  end
end