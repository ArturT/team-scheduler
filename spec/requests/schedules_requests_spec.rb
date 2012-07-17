require 'spec_helper'

describe 'Schedules Requests' do

  before do
    login_with_google_auth
    create(:project)
  end

  describe 'GET project/:project_id/schedules/new' do
    before do
      create(:developer)
      visit new_project_schedule_path(:project_id => 1)
    end

    it "has a project name field" do
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has a start date field" do
      page.should have_selector 'input#schedule_start_date'
    end

    it "has an end date field" do
      page.should have_selector 'input#schedule_end_date'
    end

    it "has errors message" do
      fill_in 'Start date', :with => '2012-01-31'
      fill_in 'End date', :with => '2012-01-01'
      click_button 'Create Schedule'
      page.should have_content("Start date is greater than end date")
    end
  end

  describe 'GET project/:project_id/schedules/:id/edit' do
    before do
      create(:schedule)
      visit edit_project_schedule_path(:id => 1, :project_id => 1)
    end

    it "has a project name field" do
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has a start date field" do
      page.should have_selector 'input#schedule_start_date'
    end

    it "has an end date field" do
      page.should have_selector 'input#schedule_end_date'
    end
  end

  describe 'GET schedules/new' do
    before do
      create(:developer)
      visit new_schedule_path()
    end

    it "has list of project dropdown" do
      page.should have_selector "select[name='schedule[project_id]']"
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has a start date field" do
      page.should have_selector 'input#schedule_start_date'
    end

    it "has an end date field" do
      page.should have_selector 'input#schedule_end_date'
    end

    it "has errors message" do
      fill_in 'Start date', :with => '2012-01-31'
      fill_in 'End date', :with => '2012-01-01'
      click_button 'Create Schedule'
      page.should have_content("Start date is greater than end date")
    end
  end
end