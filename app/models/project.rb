class Project < ActiveRecord::Base
  has_many :schedules, :dependent => :destroy
  attr_accessible :name, :color, :company_id

  validates :name, :presence => true
  validates :company_id, :presence => true
  validates :color, :presence => true, :uniqueness => true
  validates_format_of :color, :with => /^#[0-9a-f]{6}$/i, :message => "format is not valid"
end
