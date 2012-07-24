require 'spec_helper'

describe Company do
  it 'builds a valid factory' do
    build(:company).should be_valid
  end

  it 'validates presence of name' do
    build(:company, :name => '').should_not be_valid
  end

  it 'validates presence of domain' do
    build(:company, :domain => '').should_not be_valid
  end
end
