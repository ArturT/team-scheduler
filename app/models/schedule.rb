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
      errors.add(:start_date, 'is greater than end date')
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

  def update_schedule(attributes)
    prev_default_hours = default_hours
    if update_attributes(attributes)
      change_default_hours(prev_default_hours)
      delete_dates_before_start_date
      delete_dates_after_end_date
      true
    else
      false
    end
  end

  def delete_dates_before_start_date
    non_default_days.where('date < ?', start_date).delete_all
  end

  def delete_dates_after_end_date
    non_default_days.where('date > ?', end_date).delete_all
  end

  def change_default_hours(prev_default_hours)
    unless prev_default_hours == default_hours
      (start_date...Date.today).each do |date|
        # if a non_default_day exists for this date, if its hours match default hours delete it
        if non_default_day = non_default_days.find{ |d| d.date == date }
          if non_default_day.hours == default_hours
            NonDefaultDay.delete(non_default_day.id)
          end
          # else create a new non_default_day with the previous default hours
        else
          NonDefaultDay.new(:schedule_id => id, :hours => prev_default_hours, :date => date).save
        end
      end
    end
  end

  def create_weekend_days
    (start_date..end_date).each do |date|
      # .wday 0 == Sunday, wday 6 == Saturday
      if date.wday == 0 || date.wday == 6
        NonDefaultDay.new(:schedule_id => id, :hours => 0, :date => date).save
      end
    end
  end

  def hours_to_fraction(hours)
    hours.to_s + "/" + default_hours.to_s
  end
end
