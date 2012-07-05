require 'spec_helper'

describe "projects" do
  describe "GET /projects" do
    before do
      FactoryGirl.create(:project)
      visit projects_path
    end

    it "renders list of projects" do
      page.should have_content "List Of Projects"
    end

    it "has edit link" do
      page.should have_link 'edit'
    end

    it "has delete link" do
      page.should have_link 'delete'
    end

    it "has new project link" do
      page.should have_link 'Add New Project'
    end

    it "displays all projects' names" do
      page.should have_selector("li")
      page.should have_content "ProjectName"
    end
  end

  describe "GET /projects/new" do
    it "renders form for project fields" do
      visit new_project_path
      page.should have_selector "input", :name => 'name'
    end

    it "adds new project" do
      visit new_project_path
      fill_in 'Name', :with => 'DevName'
      click_button 'Create Project'
    end
  end

  describe "GET /projects/edit" do
    before do
      FactoryGirl.create(:project)
    end

    it "renders populated for for project fields" do
      visit edit_project_path(:id => 1)
      page.should have_selector "input", {:name => "name", :value => "ProjectName"}
    end

    it "updates project name" do
      visit edit_project_path(:id => 1)
      fill_in "Name", :with => "ChangedName"
      click_button "Update Project"
    end
  end
end
