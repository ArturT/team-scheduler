require 'spec_helper'

describe "NonDefaultDays Specs" do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :developer => developer, :project => project) }
  let(:non_default_day) { create(:non_default_day, :schedule => schedule) }

  before do
    login_with_google_auth(company)
  end

  describe "GET /projects/:project_id/schedules/:schedule_id/days/new" do
    before do
      visit new_project_schedule_day_path(:project_id => project.id, :schedule_id => schedule.id, :date => Date.today)
    end

    context "hours are valid" do
      it "adds new non default day" do
        page.select('6', :from => 'non_default_day_hours')
        click_on 'Save Hours'
        page.should have_content 'Day hours have been saved.'
        page.should have_css 'a', :title => 'ProjectName | Time: 6/8'
      end
    end

    context "hours are the same as default" do
      it "returns an error" do
        page.select('8', :from => 'non_default_day_hours')
        click_on 'Save Hours'
        page.should have_content "Day hours have not been changed."
      end
    end
  end
end