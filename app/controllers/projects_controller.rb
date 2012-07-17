class ProjectsController < ApplicationController
  before_filter :find_company_by_name, :only => [:index, :new, :create, :edit, :update]
  before_filter :find_project_by_id, :only => [:edit, :update, :destroy, :show]

  def index
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(params[:project])
    if @project.save
      flash[:success] = 'Project was created.'
      redirect_to project_path(@project)
    else
      render :new
    end
  end


  def edit
  end

  def update
    if @project.update_attributes(params[:project])
      flash[:success] = 'Project was updated.'
      redirect_to project_path(@project)
    else
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:info] = 'Project was deleted.'
    redirect_to projects_path
  end

  def show
    @schedules = Schedule.find_all_by_project_id(params[:id])
  end

  private
  def find_company_by_name
    @company = Company.find_by_name(session[:authenticated])
  end

  def find_project_by_id
    @project = Project.find(params[:id])
  end
end