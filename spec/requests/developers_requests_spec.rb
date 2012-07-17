require 'spec_helper'

describe "Developers Specs" do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  before do
    login_with_google_auth(company)
  end

  describe "GET /developers" do
    before do
      create(:developer, :company => company)
      visit developers_path
    end

    it "renders list of developers" do
      page.should have_content 'List Of Developers'
      page.should have_content 'DevName'
    end

    it "has edit link" do
      page.should have_link 'edit'
      click_on 'edit'
      page.should have_selector 'input', :value => 'DevName'
    end

    it "has delete link" do
      page.should have_link 'delete'
      click_on 'delete'
      page.should_not have_content 'DevName'
    end

    it "has new developer link" do
      page.should have_link 'Add New Developer'
      click_on 'Add New Developer'
      page.should have_selector 'input', :name => 'name'
    end
  end

  describe "GET /developers/new" do
    before do
      visit new_developer_path
    end

    it "adds new developer" do
      page.should have_selector "input", :name => 'name'
      fill_in 'Name', :with => 'AddNewName'
      click_on 'Create Developer'
      page.should have_content 'AddNewName'
    end

    it "has errors message" do
      click_on 'Create Developer'
      page.should have_content("can't be blank")
    end
  end

  describe "GET /developers/edit" do
    it "updates developer name" do
      visit edit_developer_path(:id => developer.id)
      page.should have_selector "input", {:name => "name", :value => "DevName"}
      fill_in 'Name', :with => 'ChangedName'
      click_on "Update Developer"
      page.should have_content 'ChangedName'
    end
  end
end
