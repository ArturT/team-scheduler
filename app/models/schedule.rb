class Schedule < ActiveRecord::Base
  has_many :non_default_days, :dependent => :destroy
  belongs_to :developer
  delegate :name, :to => :developer, :prefix => true
  belongs_to :project
  delegate :name, :color, :to => :project, :prefix => true
  attr_accessible :developer_id, :end_date, :project_id, :start_date

  validates :developer_id, :presence => true
  validates :project_id, :presence => true
  validates :start_date, :presence => true
  validates :end_date, :presence => true
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
end
