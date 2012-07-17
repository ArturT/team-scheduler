class DevelopersController < ApplicationController
  before_filter :find_company_by_name, :only => [:index, :new, :create, :edit, :update]
  before_filter :find_developer_by_id, :only => [:edit, :update, :destroy]

  def index
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])
    if @developer.save
      flash[:success] = 'Developer was created.'
      redirect_to developers_path()
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @developer.update_attributes(params[:developer])
      flash[:success] = 'Developer was updated.'
      redirect_to developers_path()
    else
      render :edit
    end
  end

  def destroy
    @developer.destroy
    flash[:info] = 'Developer was deleted.'
    redirect_to developers_path()
  end

  private
  def find_company_by_name
    @company = Company.find_by_name(session[:authenticated])
  end

  def find_developer_by_id
    @developer = Developer.find(params[:id])
  end
end