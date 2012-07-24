require 'spec_helper'

describe "Projects Requests" do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :developer => developer, :project => project) }

  before do
    login_with_google_auth(company)
  end

  describe "GET /projects" do
    before do
      create(:project, :company => company)
      visit projects_path
    end

    it "checks hex color generator" do
      color = "#" + ("%06x" % (rand * 0xffffff))
      color.should match /^#[0-9a-f]{6}$/i
    end

    it "has projects listed" do
      company.projects.count.should_not == 0
    end

    it "renders list of projects" do
      page.should have_content 'List Of Projects'
      page.should have_content 'ProjectName'
    end

    it "has edits project link" do
      page.should have_link 'edit'
      click_on 'edit'
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has deletes project link" do
      page.should have_link 'delete'
      click_on 'delete'
      page.should_not have_content 'ProjectName'
    end

    it "has new project link" do
      page.should have_link 'Add New Project'
      click_on 'Add New Project'
      page.should have_selector 'input', :name => 'name'
    end
  end

  describe "GET /projects/new" do
    before do
      visit new_project_path
    end

    it "adds new project" do
      page.should have_selector 'input', :name => 'name'
      page.should have_selector 'input', :color => '#000000'
      fill_in 'Name', :with => 'Test Project'
      fill_in 'Color', :with => '#ffffff'
      click_on 'Create Project'
      page.should have_content('Test Project')
    end

    it "has errors message" do
      click_on 'Create Project'
      page.should have_content("can't be blank")
    end
  end

  describe "GET /projects/edit" do
    it "updates project name" do
      visit edit_project_path(project.id)
      page.should have_selector "input", {:name => "name", :value => "ProjectName"}
      fill_in "Name", :with => "ChangedName"
      click_on "Update Project"
      page.should have_content "ChangedName"
    end
  end

  describe "GET /projects/show" do
    before do
      create(:schedule, :developer => developer, :project => project)
      visit project_path(project.id)
    end

    it "shows a list of developers on this project" do
      page.should have_content 'ProjectName'
      page.should have_content 'DevName'
    end

    it "renders edit template for the schedule" do
      click_on 'edit'
      page.should have_selector('input', :value => 'ProjectName')
      page.should have_selector('input', :value => 'DevName')
    end

    it "deletes the schedule" do
      click_on 'delete'
      page.should_not have_content "DevName"
    end

    it "renders new template for schedule" do
      click_on 'Add Developer to This Project'
      page.should have_selector('input', :value=> 'ProjectName')
      page.should have_content 'DevName'
    end

    it "goes back to list of projects" do
      click_on 'Back'
      page.should have_content 'ProjectName'
    end
  end
end
