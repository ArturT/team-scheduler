require 'spec_helper'

describe DayTypesController do
  
  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }
  let(:day_type) { create(:day_type, :schedule => schedule) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe "edit" do
    it "gets the day type from the db" do
      get :edit, {:id => day_type.id}
      assigns(:day_type).hours.should == 8
      assigns(:day_type).date.should == "2012-01-01".to_date
    end
  end

  describe "update" do
    context "when params are correct" do
      it "gets day type from db" do
        post :update, {:id => day_type.id}
        assigns(:day_type).hours.should == 8
        assigns(:day_type).date.should == "2012-01-01".to_date
      end

      def dispatch
        post :update, {
          :id => day_type.id, 
          :day_type => {
            :hours => "6", # change only hours
            :date => day_type.date # the same date
          }
        }
      end

      it "updates day type in db" do
        DayType.find(day_type.id).date.should == "2012-01-01".to_date
        DayType.find(day_type.id).hours.should == 8
        dispatch
        DayType.find(day_type.id).date.should == "2012-01-01".to_date
        DayType.find(day_type.id).hours.should == 6
      end
    end

    context "when params are incorrect" do
      it "update attributes fails" do
        post :update, {
          :id => day_type.id,
          :day_type => {
            :date => "2012-01-01",
            :hours => ''
          }
        }
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    it "delete day type" do
      day_type = create(:day_type, :schedule => schedule)
      expect { post :destroy, :id => day_type.id }.to change{ DayType.count }.by(-1)
    end
  end
end