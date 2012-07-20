class ChangeDayTypeName < ActiveRecord::Migration
  def change
    rename_table :day_types, :non_default_days
  end
end
