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

  def date_range
    start_date..end_date
  end

  def days
    @days ||= days_load
  end

  def days_load
    list_of_days = []
    non_defaults = non_default_days # non_default_days (from has_many relation)
    date_range.each do |date|
      if non_default = non_defaults.find { |ndd| ndd.date == date }
        list_of_days << non_default
      else
        list_of_days << DefaultDay.new(date, default_hours)
      end
    end
    list_of_days
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
