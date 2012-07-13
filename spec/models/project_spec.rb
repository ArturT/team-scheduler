require 'spec_helper'

describe Project do
  context "when params are correct" do
    it "validates name of project" do
      build(:project, :name => 'ProjectName').should be_valid
    end

    it "validates format of color" do
      build(:project, :color => '#123ABC').should be_valid
    end
  end

  context "when params are incorrect" do
    it "validates name of project" do
      build(:project, :name => '').should_not be_valid
    end

    it "validates color of project" do
      build(:project, :color => '').should_not be_valid
    end

    it "validates format of color" do
      build(:project, :color => '#123EFG').should_not be_valid
    end
  end
end
