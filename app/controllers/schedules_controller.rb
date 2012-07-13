class SchedulesController < ApplicationController

  before_filter :find_project_and_developers, :only => [:new, :edit]

  before_filter :only => [:edit, :update, :destroy] do
    @schedule = Schedule.find(params[:id])
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      flash[:notice] = 'Schedule was created.'
      redirect_to project_path(params[:project_id])
    else
      find_project_and_developers
      render :new
    end
  end

  def edit

  end

  def update
    if @schedule.update_attributes(params[:schedule])
      flash[:notice] = 'Schedule was updated.'
      redirect_to project_path(params[:project_id])
    else
      find_project_and_developers
      render :edit
    end
  end

  def destroy
    @schedule.destroy
    flash[:notice] = 'Schedule was deleted.'
    flash[:notice_class] = 'error'
    redirect_to project_path(params[:project_id])
  end

  private
  def find_project_and_developers
    @project = Project.find(params[:project_id])
    @developers = Developer.all
  end
end