class BoardsController < ApplicationController
  def index
    @developers = Developer.all
    @date = params[:date] ? params[:date].to_date : Date.today
    @dates = @date.beginning_of_month..@date.end_of_month
  end
end