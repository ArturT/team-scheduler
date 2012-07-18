require 'spec_helper'

describe DayType do
  it "validates presence of date" do
    build(:day_type, :date => '').should_not be_valid
  end

  it "validates presence of type" do
    build(:day_type, :hours => nil).should_not be_valid
  end

  it "validates presence of schedule id" do
    build(:day_type, :schedule_id => nil).should_not be_valid
  end

  it "validates that type is 0, 2, 4, 6 or 8" do
    build(:day_type, :hours => 3).should_not be_valid
    build(:day_type, :hours => 0).should be_valid
    build(:day_type, :hours => 2).should be_valid
    build(:day_type, :hours => 4).should be_valid
    build(:day_type, :hours => 6).should be_valid
    build(:day_type, :hours => 8).should be_valid
  end
end
