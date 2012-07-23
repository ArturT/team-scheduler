class NonDefaultDaysController < ApplicationController
  before_filter :find_non_default_day_by_id, :only => [:edit, :update]
  before_filter :find_schedule_by_id, :only => [:new, :create, :edit, :update]
  before_filter :initialize_default_hours_hash, :only => [:new, :create, :edit, :update]

  def change
    if params[:id].to_i == -1
      redirect_to new_project_schedule_day_path(params[:project_id], params[:schedule_id], :date => params[:date])
    else
      redirect_to edit_project_schedule_day_path(params[:project_id], params[:schedule_id], params[:id])
    end
  end

  def new
    @non_default_day = NonDefaultDay.new(:date => params[:date])
  end

  def create
    @non_default_day = NonDefaultDay.new(params[:non_default_day])

    if params[:non_default_day][:hours].to_i == @schedule.default_hours
      flash[:error] = "Day hours haven't been changed."
      render :new, :params => { :date => params[:date] }
    elsif @non_default_day.save
      flash[:success] = "Day hours have been saved."
      redirect_to board_index_path
    else
      render :new, :params => { :date => params[:date] }
    end
  end

  def edit
  end

  def update
    if params[:non_default_day][:hours].to_i == @schedule.default_hours
      NonDefaultDay.delete(params[:id])
      redirect_to board_index_path
    else
      if @non_default_day.update_attributes(params[:non_default_day])
        redirect_to board_index_path
      else
        render :edit
      end
    end
  end

  private
  def find_non_default_day_by_id
    @non_default_day = NonDefaultDay.find(params[:id])
  end

  def find_schedule_by_id
    @schedule = Schedule.find(params[:schedule_id])
  end
end