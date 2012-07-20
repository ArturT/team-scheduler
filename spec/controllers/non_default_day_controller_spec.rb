require 'spec_helper'

describe NonDefaultDaysController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }
  let(:non_default_day) { create(:non_default_day, :schedule => schedule) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe "new" do
    before do
      get :new, :project_id => project.id, :schedule_id => schedule.id
    end

    it "renders new form" do
      response.should render_template("new")
    end

    it "assigns new non_default_day object" do
      assigns(:non_default_day).should be_a_new(NonDefaultDay)
    end
  end

  describe "create" do
    before do
      post :create, :project_id => project.id, :schedule_id => schedule.id, :non_default_day => {:schedule_id => schedule.id, :date => Date.today, :hours => 4}
    end

    it "add new non_default_day object" do
      pending
    end

    it "redirects to board index" do
      pending
      response.should redirect_to board_index_path
    end
  end

  describe "edit" do

  end

  describe "update" do

  end
end