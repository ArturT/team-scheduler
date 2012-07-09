require 'spec_helper'

describe BoardsController do
  describe "index" do
    context "no date in the parameters" do
      before do
        create(:developer)
        get :index
      end

      it "renders index" do
        page.should render_template("index")
      end

      it "has a list of all developers" do
        developers = assigns(:developers)
        developers.count.should == 1
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
      before do
        create(:developer)
        get :index, :date => Date.today.next_month
      end

      it "has the date passed in params" do
        assigns(:date).should == Date.today.next_month
      end
    end
  end
end