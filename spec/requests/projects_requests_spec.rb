require 'spec_helper'

describe "projects" do
  describe "GET /projects" do
    before do
      create(:project)
      visit projects_path
    end

    it "renders list of projects" do
      page.should have_content 'List Of Projects'
      page.should have_content 'ProjectName'
    end

    it "has edits project link" do
      page.should have_link 'edit'
      click_link 'edit'
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has deletes project link" do
      page.should have_link 'delete'
      click_link 'delete'
      page.should_not have_content 'ProjectName'
    end

    it "has new project link" do
      page.should have_link 'Add New Project'
      click_link 'Add New Project'
      page.should have_selector 'input', :name => 'name'
    end
  end

  describe "GET /projects/new" do
    it "adds new project" do
      visit new_project_path
      page.should have_selector 'input', :name => 'name'
      fill_in 'Name', :with => 'ProjectName'
      click_button 'Create Project'
      page.should have_content('ProjectName')
    end
  end

  describe "GET /projects/edit" do
    it "updates project name" do
      create(:project)
      visit edit_project_path(:id => 1)
      page.should have_selector "input", {:name => "name", :value => "ProjectName"}
      fill_in "Name", :with => "ChangedName"
      click_button "Update Project"
      page.should have_content "ChangedName"
    end
  end
end
