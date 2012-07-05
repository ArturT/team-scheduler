require 'spec_helper'

describe "developers" do
  describe "GET /developers" do
    it "renders list of developers" do
      Developer.new(:name => "dev").save
      visit developers_path
      page.should have_content "developers list"
    end

    it "displays all developers' names" do
      Developer.new(:name => "dev_name").save
      visit developers_path

      page.should have_selector("li")
      page.should have_content "dev_name"
    end
  end
end
