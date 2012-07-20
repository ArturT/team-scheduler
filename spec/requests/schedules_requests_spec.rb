require 'spec_helper'

describe 'Schedules Requests' do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  before do
    login_with_google_auth
  end

  describe 'GET project/:project_id/schedules/new' do
    before do
      visit new_project_schedule_path(:project_id => project.id)
    end

    it "has a project name field" do
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has a default hours selector" do
      page.should have_content "Default hours"
    end

    it "has select option 1/4th day, etc" do
      page.has_select?('Default hours', :options => ['off or sick', '2 hours', '4 hours', '6 hours', '8 hours']).should == true
    end

    it "has select option where selected is 8 hours" do
      page.has_select?('Default hours', :selected => '8 hours').should == true
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
      click_on 'Create Schedule'
      page.should have_content("Start date is greater than end date")
    end
  end

  describe 'GET project/:project_id/schedules/:id/edit' do
    before do
      visit edit_project_schedule_path(:id => schedule.id, :project_id => project.id)
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
      visit new_schedule_path
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
      click_on 'Create Schedule'
      page.should have_content("Start date is greater than end date")
    end
  end
end