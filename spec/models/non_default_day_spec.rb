require 'spec_helper'

describe NonDefaultDay do
  it "validates presence of date" do
    build(:non_default_day, :date => '').should_not be_valid
  end

  it "validates presence of type" do
    build(:non_default_day, :hours => nil).should_not be_valid
  end

  it "validates presence of schedule id" do
    build(:non_default_day, :schedule_id => nil).should_not be_valid
  end

  it "validates that type is 0, 2, 4, 6 or 8" do
    build(:non_default_day, :hours => 3).should_not be_valid
    build(:non_default_day, :hours => 0).should be_valid
    build(:non_default_day, :hours => 2).should be_valid
    build(:non_default_day, :hours => 4).should be_valid
    build(:non_default_day, :hours => 6).should be_valid
    build(:non_default_day, :hours => 8).should be_valid
  end
end
