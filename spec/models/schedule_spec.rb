require 'spec_helper'

describe Schedule do
  it "builds a valid factory" do
    build(:schedule).should be_valid
  end

  context "when values are invalid" do
    it "validates that it has a developer id" do
      build(:schedule, :developer_id => nil).should_not be_valid
    end

    it "validates that it has a project id" do
      build(:schedule, :project_id => nil).should_not be_valid
    end

    it "validates that it has a start date" do
      build(:schedule, :start_date => '').should_not be_valid
    end

    it "validates that is has an end date" do
      build(:schedule, :end_date => '').should_not be_valid
    end

    it "validates that there are default hours" do
      build(:schedule, :default_hours => nil).should_not be_valid
    end

    it "validates that the start date is before the end date" do
      build(:schedule, :start_date => "2012-01-31", :end_date => "2012-01-01").should_not be_valid
    end
  end

  it "returns a date range" do
    build(:schedule).date_range.should == (Date.today.beginning_of_month..Date.today.end_of_month)
  end

  context "when there are no non_default_days in db" do
    before do
      @schedule = create(:schedule)
    end

    it "all days show up as default" do
      @schedule.days.each do |day|
        day.hours.should == @schedule.default_hours
      end
    end
  end

  context "when there are non_default_days in db" do
    before do
      @schedule = create(:schedule)
      @non_default_day = create(:non_default_day, :date => Date.today, :schedule => @schedule)
    end

    it "one day should be non default" do
      @schedule.days.find{ |d| d.hours == 4 }.should_not be_nil
    end
  end
end
