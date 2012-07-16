class Developer < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  attr_accessible :name, :company_id

  validates :name, :presence => true
  validates :company_id, :presence => true
end
