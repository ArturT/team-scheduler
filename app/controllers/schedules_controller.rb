class SchedulesController < ApplicationController
  before_filter :find_project_and_developers, :only => [:new, :edit]
  before_filter :find_project_by_id, :only => [:edit, :update, :destroy]

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(params[:schedule])

    if @schedule.save
      #save each day_type object with default type
      @schedule.date_range.each do |date|
        DayType.new(:date => date, :hours => 8, :schedule_id => @schedule.id).save
      end

      flash[:success] = 'Schedule was created.'
      redirect_to project_path(params[:schedule][:project_id])
    else
      find_project_and_developers
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update_attributes(params[:schedule])
      #TODO if date range was changed add or remove day_types
      if changed_range?(@schedule)
        change_date_range(@schedule)
      end

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

  def changed_range?(schedule)
    @schedule.date_range.count != @schedule.day_types.count
  end

  def change_date_range(schedule)
    new_end_date = @schedule.end_date
    current_end_date = @schedule.day_types.last.date

    if new_end_date > current_end_date
      ((current_end_date + 1)..new_end_date).each do |date|
        DayType.new(:date => date, :hours => 8, :schedule_id => @schedule.id).save
      end
    else
      ((new_end_date+1)..current_end_date).each do |date|
        DayType.delete_all(:date => date, :schedule_id => @schedule.id)
      end
    end
  end
end