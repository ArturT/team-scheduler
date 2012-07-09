require "spec_helper"

describe "boards" do
  describe "GET /boards" do
    before do
      create(:developer)
      create(:project)
      create(:schedule)
      visit boards_path
    end

    it "render boards template" do
      page.should have_content "DevName"
      page.should have_content "ProjectName"
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
  end
end