require 'spec_helper'

describe 'Boards Requests' do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :developer => developer, :project => project) }

  before do
    login_with_google_auth(company)
  end

  describe 'GET /board' do
    before do
      create(:schedule, :developer => developer, :project => project)
      visit board_index_path
    end

    it 'render boards template' do
      page.should have_content 'DevName'
      page.should have_content 'CompanyName Developer Timetable'
    end


    it 'shows the header for the current date' do
      page.should have_content company.name + ' Developer Timetable for ' + Date.today.strftime('%B %Y')
    end


    it 'has link to developers' do
      click_on 'Developers'
      page.should have_content 'DevName'
    end

    it 'has link to projects' do
      click_on 'Projects'
      page.should have_content 'ProjectName'
    end

    it 'has link to previous month' do
      click_on 'Previous Month'
      page.should have_content Date.today.prev_month.strftime('%B %Y')
    end

    it 'has link to current month' do
      click_on 'Current Month'
      page.should have_content Date.today.strftime('%B %Y')
    end

    it 'has link to next month' do
      click_on 'Next Month'
      page.should have_content Date.today.next_month.strftime('%B %Y')
    end

    it 'highlights weekend dates' do
      page.should have_xpath("//th[@class='weekend']")
      page.should have_xpath("//td[@class='weekend']")
    end

    it 'highlights todays date' do
      page.should have_xpath("//th[@class='today']")
      page.should have_xpath("//td[@class='today']")
    end

    it 'has a button to add new developer to project' do
      page.should have_selector 'a.btn', :value => 'Add Developer to Project'
    end

    it 'has a logout feature' do
      click_on 'Logout'
      page.should have_content 'You have logged out.'
    end

    it 'has pie chart for project' do
      page.should have_xpath("//div[@class='link_container']")
    end
  end
end