class AddDeveloperAndProjectToCompany < ActiveRecord::Migration
  def change
    add_column :developers, :company_id, :integer
    add_column :projects, :company_id, :integer
  end
end
