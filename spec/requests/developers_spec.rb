require 'spec_helper'

describe "developers" do
  describe "GET /developers" do
    it "renders list of developers" do
      FactoryGirl.create(:developer)
      visit developers_path
      page.should have_content "List Of Developers"
    end

    it "displays all developers' names" do
      FactoryGirl.create(:developer)
      visit developers_path
      page.should have_selector("li")
      page.should have_content "DevName"
    end
  end

  describe "GET /developers/new" do
    it "renders form for developer fields" do
      visit new_developer_path
      page.should have_selector "input", :name => 'name'
    end

    it "adds new developer" do
      visit new_developer_path
      fill_in 'Name', :with => 'DevName'
      click_button 'Create Developer'
    end
  end

  describe "GET /developers/edit" do
    before do
      FactoryGirl.create(:developer)
    end

    it "renders populated for for developer fields" do
      visit edit_developer_path(:id => 1)
      page.should have_selector "input", {:name => "name", :value => "DevName"}
    end

    it "updates developer name" do
      visit edit_developer_path(:id => 1)
      fill_in "Name", :with => "ChangedName"
      click_button "Update Developer"
    end
  end
end
