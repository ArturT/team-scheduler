class AddRoleToDeveloper < ActiveRecord::Migration
  def change
    add_column :developers, :role, :string
  end
end
