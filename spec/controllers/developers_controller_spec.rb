require 'spec_helper'

describe DevelopersController do
  describe "index" do
    it "renders index template" do
      get :index
      response.should render_template("index")
    end

    it "assigns developers variable" do
      developer = Developer.new(:name => "dev")
      developer.save

      get :index
      assigns(:developers).should == [developer]
    end
  end
end
