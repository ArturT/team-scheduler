class AddDefaultHoursToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :default_hours, :integer
  end
end
