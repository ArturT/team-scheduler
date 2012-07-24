class Developer < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  belongs_to :company
  attr_accessible :name, :role, :company_id

  validates :name, :presence => true
  validates :role, :presence => true
  validates :company_id, :presence => true
end
