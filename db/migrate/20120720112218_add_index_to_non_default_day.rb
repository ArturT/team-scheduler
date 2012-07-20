class AddIndexToNonDefaultDay < ActiveRecord::Migration
  def change
    add_index :non_default_days, :schedule_id
  end
end
