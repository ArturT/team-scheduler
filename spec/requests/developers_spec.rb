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

  describe "GET /developers/new" do
    it "renders form for developer fields" do
      visit new_developer_path

      page.should have_selector "input", :name => 'name'
    end

    it "can add user" do
      visit new_developer_path

      fill_in 'Name', :with => 'DevName'
      click_button 'Create Developer'

    end
  end
end
