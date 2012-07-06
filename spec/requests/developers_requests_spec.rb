require 'spec_helper'

describe "developers" do
  describe "GET /developers" do
    before do
      create(:developer)
      visit developers_path
    end

    it "renders list of developers" do
      page.should have_content 'List Of Developers'
      page.should have_content 'DevName'
    end

    it "has edit link" do
      page.should have_link 'edit'
      click_link 'edit'
      page.should have_selector 'input', :value => 'DevName'
    end

    it "has delete link" do
      page.should have_link 'delete'
      click_link 'delete'
      page.should_not have_content 'DevName'
    end

    it "has new developer link" do
      page.should have_link 'Add New Developer'
      click_link 'Add New Developer'
      page.should have_selector 'input', :name => 'name'
    end
  end

  describe "GET /developers/new" do
    it "adds new developer" do
      visit new_developer_path
      page.should have_selector "input", :name => 'name'
      fill_in 'Name', :with => 'ChangeName'
      click_button 'Create Developer'
    end
  end

  describe "GET /developers/edit" do
    it "updates developer name" do
      create(:developer)
      visit edit_developer_path(:id => 1)
      page.should have_selector "input", {:name => "name", :value => "DevName"}
      fill_in "Name", :with => "ChangedName"
      click_button "Update Developer"
    end
  end
end
