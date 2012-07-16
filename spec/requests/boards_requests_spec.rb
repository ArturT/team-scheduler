require "spec_helper"

describe "Boards Requests" do

  before do
    pending
  end

  describe "GET /boards" do
    before do
      create(:developer)
      create(:project)
      create(:schedule)
      visit boards_path
    end

    it "render boards template" do
      page.should have_content "DevName"
      have_xpath("//span][@title='ProjectName']")
    end

    it "shows the header for the current date" do
      page.should have_content "Developer Timetable for " + Date.today.strftime("%B %Y")
    end


    it "has link to developers" do
      click_link 'Developers'
      page.should have_content "DevName"
    end

    it "has link to projects" do
      click_link 'Projects'
      page.should have_content "ProjectName"
    end

    it "has link to previous month" do
      click_link 'Previous Month'
      page.should have_content Date.today.prev_month.strftime("%B %Y")
    end

    it "has link to current month" do
      click_link 'Current Month'
      page.should have_content Date.today.strftime("%B %Y")
    end

    it "has link to next month" do
      click_link 'Next Month'
      page.should have_content Date.today.next_month.strftime("%B %Y")
    end

    it "highlights weekend dates" do
      page.should have_xpath("//th[@class='weekend']")
      page.should have_xpath("//td[@class='weekend']")
    end

    it "highlights today's date" do
      page.should have_xpath("//th[@class='today']")
      page.should have_xpath("//td[@class='today']")
    end

    it "has a button to add new developer to project" do
      visit boards_path
      page.should have_selector 'a.btn', :value => 'Add Developer to Project'
    end
  end
end