require 'spec_helper'

describe "NonDefaultDays Specs" do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }
  let(:non_default_day) { create(:non_default_day, :schedule => schedule) }

  before do
    login_with_google_auth(company)
  end

  describe "GET /projects/:project_id/schedules/:schedule_id/days/new" do
    before do
      visit new_project_schedule_day_path(:project_id => project.id, :schedule_id => schedule.id)
    end

    xit "adds new non default day" do
      page.should have_selector 'select', :name => 'hours'
      page.select('6', :from => 'hours')
      click_on 'Create Non Default Day'
      page.should have_xpath("//div[@class='link_container']/a[@data-original-title='ProjectName | Time: 6/8']")
    end
  end
end