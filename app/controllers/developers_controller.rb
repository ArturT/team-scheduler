class DevelopersController < ApplicationController
  def index
    @developers = Developer.all
  end

  def new
    @developer = Developer.new
  end

  def create
    @developer = Developer.new(params[:developer])
    if @developer.save
      redirect_to developers_path
    else
      render :new
    end
  end

  def edit
    @developer = Developer.find(params[:id])
  end

  def update
    @developer = Developer.find(params[:id])
    if @developer.update_attributes(params[:developer])
      redirect_to developers_path
    else
      render :edit
    end
  end

  def destroy
    Developer.find(params[:id]).delete
    redirect_to developers_path
  end
end