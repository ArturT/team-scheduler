class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.integer :developer_id
      t.integer :project_id
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
