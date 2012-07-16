class Company < ActiveRecord::Base
  has_many :developers, :dependent => :destroy
  has_many :projects, :dependent => :destroy
  attr_accessible :domain, :name

  validates :name, :presence => true
  validates :domain, :presence => true
end
