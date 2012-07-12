class AddIndexesToSchedule < ActiveRecord::Migration
  def change
    add_index :schedules, :developer_id
    add_index :schedules, :project_id
  end
end
