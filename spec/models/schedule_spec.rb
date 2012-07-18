require 'spec_helper'

describe Schedule do
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

  it "validates that the start date is before the end date" do
    build(:schedule, :start_date => "2012-01-31", :end_date => "2012-01-01").should_not be_valid
  end

  it "returns a date range" do
    build(:schedule).date_range.should == (Date.new(2012, 01, 01)..Date.new(2012, 01, 31))
  end
end
