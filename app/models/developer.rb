class Developer < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  attr_accessible :name
  validates :name, :presence => true
end
