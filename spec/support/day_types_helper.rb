module DayTypesHelper
  def create_day_types_for_schedule(schedule = FactoryGirl.create(:schedule))
    schedule.date_range.each do |date|
      create(:day_type, :date => date, :schedule => schedule)
    end
  end
end