require 'spec_helper'

describe Project do
  it "validates name of project" do
    Project.new(:name => '').should_not be_valid
  end
end
