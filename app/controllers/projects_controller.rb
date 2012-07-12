class ProjectsController < ApplicationController
  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      redirect_to project_path(@project)
    else
      render :new
    end
  end

  before_filter :only => [:edit, :update, :destroy, :show] do
    @project = Project.find(params[:id])
  end

  def edit

  end

  def update
    if @project.update_attributes(params[:project])
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    redirect_to projects_path
  end

  def show
    @schedules = Schedule.find_all_by_project_id(params[:id])
  end
end