class ChangeTypeColumnName < ActiveRecord::Migration
  def change
    rename_column :day_types, :type, :hours
  end
end
