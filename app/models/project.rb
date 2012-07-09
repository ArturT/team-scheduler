class Project < ActiveRecord::Base
  has_many :schedules
  attr_accessible :name
  validates :name, :presence => true
end
