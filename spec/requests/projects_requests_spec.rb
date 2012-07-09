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

    it "has errors message" do
      visit new_project_path
      click_button 'Create Project'
      page.should have_content("can't be blank")
    end
  end

  describe "GET /projects/edit" do
    it "updates project name" do
      create(:project)
      visit edit_project_path(1)
      page.should have_selector "input", {:name => "name", :value => "ProjectName"}
      fill_in "Name", :with => "ChangedName"
      click_button "Update Project"
      page.should have_content "ChangedName"
    end
  end

  describe "GET /projects/show" do
    before do
      create(:project)
      create(:developer)
      create(:schedule)
      visit project_path(1)
    end

    it "shows a list of developers on this project" do
      page.should have_content 'ProjectName'
      page.should have_content 'DevName'
    end

    it "renders edit template for the schedule" do
      click_link 'edit'
      page.should have_selector('input', :value=> 'ProjectName')
      page.should have_content 'DevName'
    end

    it "deletes the schedule" do
      click_link 'delete'
      page.should_not have_content "DevName"
    end

    it "renders new template for schdule" do
      click_link 'Add Developer to This Project'
      page.should have_selector('input', :value=> 'ProjectName')
      page.should have_content 'DevName'
    end

    it "goes back to list of projects" do
      click_link 'Back'
      page.should have_content 'ProjectName'
    end
  end
end
