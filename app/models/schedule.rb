class Schedule < ActiveRecord::Base
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
  validates :default_hours, :presence => true
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
    list_of_days = []
    date_range.each do |date|
      non_default = non_default_days.find_by_date(date)
      if non_default
        list_of_days << non_default
      else
        list_of_days << DefaultDay.new(date, default_hours)
      end
    end
    list_of_days
  end
end