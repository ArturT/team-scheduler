class SchedulesController < ApplicationController
  before_filter :find_project_and_developers, :only => [:new, :edit]
  before_filter :find_project_by_id, :only => [:edit, :update, :destroy]
  before_filter :initialize_default_hours_hash, :only => [:new, :create, :edit, :update]

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(params[:schedule])

    if @schedule.save
      flash[:success] = 'Schedule was created.'
      redirect_to project_path(params[:schedule][:project_id])
    else
      find_project_and_developers
      render :new
    end
  end

  def edit
  end

  #TODO delete non_defaults when changing the date range
  def update
    if @schedule.update_attributes(params[:schedule])
      @schedule.delete_dates_before_start_date
      @schedule.delete_dates_after_end_date

      flash[:success] = 'Schedule was updated.'
      redirect_to project_path(params[:project_id])
    else
      find_project_and_developers
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    flash[:info] = 'Schedule was deleted.'
    redirect_to project_path(params[:project_id])
  end

  private
  def find_project_and_developers
    company = Company.find_by_name(session[:authenticated])
    if params[:project_id]
      @project = Project.find(params[:project_id])
    else
      @projects = company.projects
    end
    @developers = company.developers
  end

  def find_project_by_id
    @schedule = Schedule.find(params[:id])
  end
end