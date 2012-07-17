require 'spec_helper'

describe BoardController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe "index" do
    context "no date in the parameters" do
      before do
        create(:schedule, :developer => developer, :project => project)
        get :index
      end

      it "renders index" do
        page.should render_template("index")
      end

      it "has a list of all developers" do
        company = assigns(:company)
        company.developers.count.should == 1
      end

      it "has current date" do
        assigns(:date).should be_instance_of Date
      end

      it "has a list of whole month" do
        dates = assigns(:dates)
        dates.count.should == (Date.today.beginning_of_month..Date.today.end_of_month).count
      end
    end

    context "date set in parameters" do
      it "has the date passed in params" do
        get :index, :date => Date.today.next_month
        assigns(:date).should == Date.today.next_month
      end
    end
  end
end