class NonDefaultDaysController < ApplicationController
  before_filter :find_non_default_day_by_id, :only => [:edit, :update]
  before_filter :find_project_and_schedule_by_ids, :only => [:edit, :update]
  before_filter :initialize_default_hours_hash, :only => [:new, :create, :edit, :update]

  def new
    @non_default_day = NonDefaultDay.new
  end

  def create
    @non_default_day = NonDefaultDay.new(params[:non_default_day])

    if @non_default_day.save
      flash[:success] = "Day hours have been saved."
      redirect_to board_index_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @non_default_day.update_attributes(params[:non_default_day])
      redirect_to board_index_path
    else
      render :edit
    end
  end

  private
  def find_non_default_day_by_id
    @non_default_day = NonDefaultDay.find(params[:id])
  end

  def find_project_and_schedule_by_ids
    @project = Project.find(params[:project_id])
    @schedule = Schedule.find(params[:schedule_id])
  end
end