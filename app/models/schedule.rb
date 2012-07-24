class Schedule < ActiveRecord::Base
  include ActiveModel::Validations

  has_many :non_default_days, :dependent => :destroy
  belongs_to :developer
  delegate :name, :to => :developer, :prefix => true
  belongs_to :project
  delegate :name, :color, :to => :project, :prefix => true
  attr_accessible :developer_id, :end_date, :project_id, :start_date, :default_hours

  validates :developer_id, :presence => true
  validates :project_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
  validates :default_hours, :presence => true, :working_hours_scope => true
  validate :valid_dates?

  def valid_dates?
    return unless start_date && end_date
    if start_date > end_date
      errors.add(:start_date, "is greater than end date")
    end
  end

  def day_between_date_range(date)
    if date >= start_date && date <= end_date
      if day = non_default_days.find{ |d| d.date == date }
      else
        day = DefaultDay.new(date, default_hours)
      end
      day
    else
      nil
    end
  end

  def delete_dates_before_start_date
    non_default_days.where('date < ?', start_date).delete_all
  end

  def delete_dates_after_end_date
    non_default_days.where('date > ?', end_date).delete_all
  end

  def update_schedule(attributes)
    if update_attributes(attributes)
      delete_dates_before_start_date
      delete_dates_after_end_date
      true
    else
      false
    end
  end
end
