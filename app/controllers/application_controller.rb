class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticated

  def authenticated
    unless session[:authenticated]
      flash[:error] = 'You must be logged in to view this page'
      redirect_to root_path
    end
  end

  def initialize_default_hours_hash
    @default_hours = {
      'off or sick' => 0,
      '2 hours' => 2,
      '4 hours' => 4,
      '6 hours' => 6,
      '8 hours' => 8
    }
  end
end
