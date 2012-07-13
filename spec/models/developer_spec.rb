require 'spec_helper'

describe Developer do
  it "validates presence of name" do
    build(:developer, :name => '').should_not be_valid
  end
end
