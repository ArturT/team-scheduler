class NonDefaultDay < ActiveRecord::Base
  include ActiveModel::Validations

  belongs_to :schedule
  attr_accessible :date, :schedule_id, :hours

  validates :date, :presence => true
  validates :hours, :presence => true, :working_hours_scope => true
  validates :schedule_id, :presence => true
  #validate :create_default_hour?

  def create_default_hour?
    if hours == schedule.default_hours
      errors.add(:hours, 'have not been changed')
    end
  end

  def is_default_hours?
    hours == schedule.default_hours
  end
end
