require 'spec_helper'

describe 'schedules' do
  describe 'GET project/:project_id/schedules/new' do
    before do
      create(:project)
      visit new_project_schedule_path(:project_id => 1)
    end

    it "has a project name field" do
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has list of start date dropdown" do
      page.should have_selector "select[name='schedule[start_date(1i)]']"
      page.should have_selector "select[name='schedule[start_date(2i)]']"
      page.should have_selector "select[name='schedule[start_date(3i)]']"
    end

    it "has list of end date dropdown" do
      page.should have_selector "select[name='schedule[end_date(1i)]']"
      page.should have_selector "select[name='schedule[end_date(2i)]']"
      page.should have_selector "select[name='schedule[end_date(3i)]']"
    end
  end

  describe 'GET project/:project_id/schedules/:id/edit' do
    before do
      create(:project)
      create(:schedule)
      visit edit_project_schedule_path(:id => 1, :project_id => 1)
    end

    it "has a project name field" do
      page.should have_selector 'input', :value => 'ProjectName'
    end

    it "has list of developer dropdown" do
      page.should have_selector "select[name='schedule[developer_id]']"
    end

    it "has list of start date dropdown" do
      page.should have_selector "select[name='schedule[start_date(1i)]']"
      page.should have_selector "select[name='schedule[start_date(2i)]']"
      page.should have_selector "select[name='schedule[start_date(3i)]']"
    end

    it "has list of end date dropdown" do
      page.should have_selector "select[name='schedule[end_date(1i)]']"
      page.should have_selector "select[name='schedule[end_date(2i)]']"
      page.should have_selector "select[name='schedule[end_date(3i)]']"
    end
  end
end