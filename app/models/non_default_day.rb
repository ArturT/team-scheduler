class NonDefaultDay < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :schedule
  attr_accessible :date, :schedule_id, :hours

  validates :date, :presence => true
  validates :hours, :presence => true, :working_hours_scope => true
  validates :schedule_id, :presence => true
end
