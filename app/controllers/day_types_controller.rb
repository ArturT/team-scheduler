class DayTypesController < ApplicationController
  before_filter :find_day_type_by_id, :only => [:edit, :update, :destroy]

  def edit
  end

  def update
    if @day_type.update_attributes(params[:day_type])
      flash[:success] = 'Day type was updated.'
      redirect_to board_index_path
    else
      render :edit
    end
  end

  def destroy
    @day_type.destroy
    flash[:info] = 'Day type was deleted.'
    redirect_to board_index_path
  end

  private
  def find_day_type_by_id
    @day_type = DayType.find(params[:id])
  end
end