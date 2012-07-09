class SchedulesController < ApplicationController
  def new
    @project = Project.find(params[:project_id])
    @schedule = Schedule.new
    @developers = Developer.all
  end

  def create
    @schedule = Schedule.new(params[:schedule])
    if @schedule.save
      redirect_to project_path(params[:project_id])
    else
      @project = Project.find(params[:project_id])
      @developers = Developer.all
      render :new
    end
  end

  def edit
    @project = Project.find(params[:project_id])
    @schedule = Schedule.find(params[:id])
    @developers = Developer.all
  end

  def update
    @schedule = Schedule.find(params[:id])
    if @schedule.update_attributes(params[:schedule])
      redirect_to project_path(params[:project_id])
    else
      @project = Project.find(params[:project_id])
      @developers = Developer.all
      render :edit
    end
  end

  def destroy
    @schedule = Schedule.find(params[:id])
    @schedule.destroy
    redirect_to project_path(params[:project_id])
  end
end