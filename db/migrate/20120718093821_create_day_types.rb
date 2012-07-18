class CreateDayTypes < ActiveRecord::Migration
  def change
    create_table :day_types do |t|
      t.date :date
      t.integer :type
      t.integer :schedule_id

      t.timestamps
    end
  end
end
