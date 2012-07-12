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

  before_filter :only => [:edit, :update, :destroy] do
    @developer = Developer.find(params[:id])
  end

  def edit

  end

  def update
    if @developer.update_attributes(params[:developer])
      redirect_to developers_path
    else
      render :edit
    end
  end

  def destroy
    @developer.destroy
    redirect_to developers_path
  end
end