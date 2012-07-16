class AddLlpDomain < ActiveRecord::Migration
  def change
    Company.new(:name => "Lunar Logic", :domain => "llp.pl").save
  end
end