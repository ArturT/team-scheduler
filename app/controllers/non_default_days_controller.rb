class NonDefaultDaysController < ApplicationController

  before_filter :initialize_default_hours_hash, :only => [:new, :create, :edit, :update]

  def new
    @non_default_day = NonDefaultDay.new
  end

  def create
    redirect_to board_index_path
  end
end