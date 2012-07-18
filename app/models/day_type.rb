class DayType < ActiveRecord::Base
  belongs_to :schedule
  attr_accessible :date, :schedule_id, :hours

  validates :date, :presence => true
  validates :hours, :presence => true
  validates :schedule_id, :presence => true

  # 0 = off day or sick day
  # 2 =  1/4 day
  # 4 = 1/2 day
  # 6 = 3/4 day
  # 8 = full day
  validates_inclusion_of :hours, :in => (0..8).step(2)
end
