require 'spec_helper'

describe Developer do
  it "validates presence of name" do
    build(:developer, :name => '').should_not be_valid
  end

  it "validates presence of a company id" do
    build(:developer, :company_id => nil).should_not be_valid
  end
end
