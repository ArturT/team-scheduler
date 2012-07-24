require 'spec_helper'

describe Schedule do
  it 'builds a valid factory' do
    build(:schedule).should be_valid
  end

  context 'when values are invalid' do
    it 'validates that it has a developer id' do
      build(:schedule, :developer_id => nil).should_not be_valid
    end

    it 'validates that it has a project id' do
      build(:schedule, :project_id => nil).should_not be_valid
    end

    it 'validates that it has a start date' do
      build(:schedule, :start_date => '').should_not be_valid
    end

    it 'validates that is has an end date' do
      build(:schedule, :end_date => '').should_not be_valid
    end

    it 'validates that there are default hours' do
      build(:schedule, :default_hours => nil).should_not be_valid
    end

    it 'validates that the start date is before the end date' do
      build(:schedule, :start_date => '2012-01-31', :end_date => '2012-01-01').should_not be_valid
    end
  end

  context "when there are overlapping schedules in the db" do
    before do
      @developer = create(:developer)
      @project = create(:project)
      create(:schedule, :start_date => "2012-01-10", :end_date => "2012-01-20", :project => @project, :developer => @developer)
    end

    it "validates when dates overlap near start_date" do
      build(:schedule, :start_date => "2012-01-01", :end_date => "2012-01-13", :project => @project, :developer => @developer).should_not be_valid
    end

    it "validates when dates overlap near end_date" do
      build(:schedule, :start_date => "2012-01-17", :end_date => "2012-01-30", :project => @project, :developer => @developer).should_not be_valid
    end
  end

  context 'when there are no non_default_days in db' do
    before do
      @schedule = create(:schedule)
    end
  end

  context 'when there are non_default_days in db' do
    before do
      @schedule = create(:schedule)
      @non_default_day = create(:non_default_day, :date => Date.today, :schedule => @schedule)
    end

    it 'one day should be non default' do
      @schedule.non_default_days.find{ |d| d.hours == 4 }.should_not be_nil
    end
  end

  context 'when default hours has not been changes' do
    it 'does not do anything when calling change_default_hours' do
      @schedule = create(:schedule)
      # run change_default_hours on the same hours that are already in the schedule
      @schedule.change_default_hours(8)
      @schedule.non_default_days.count.should == 0
    end
  end

  context 'when default hours has changed' do
    it 'create a non_default_day for each day before today' do
      # create schedule with default hours of 8
      @schedule = create(:schedule)
      # simulate edit action to change default hours to 4
      @schedule.update_attribute(:default_hours, 4)
      # run change_default_hours with the previous default hours of 8
      @schedule.change_default_hours(8)
      days_from_start_to_today = (@schedule.start_date...Date.today).count
      # check that new 8 hours non_default_days have been created
      @schedule.non_default_days.count.should == days_from_start_to_today
      @schedule.non_default_days.find_all{ |d| d.date < Date.today }.each do |non_default_day|
        non_default_day.hours.should == 4
      end
    end

    it 'deletes all non_default_days that are the same as the new default hours' do
      # create schedule with default hours of 8
      @schedule = create(:schedule)
      # add a bunch of non_default_days with hours 4
      (@schedule.start_date...Date.today).each do |date|
        create(:non_default_day, :schedule => @schedule, :hours => 4, :date => date)
      end
      # simulate edit action to change default hours to 4
      @schedule.update_attribute(:default_hours, 4)
      # run change_default_hours with the previous default hours of 8
      @schedule.change_default_hours(8)
      # this method should delete all non_default_days that have hours 4 as that is the default hours anyway
      @schedule.non_default_days.count.should == 0
    end
  end
end
