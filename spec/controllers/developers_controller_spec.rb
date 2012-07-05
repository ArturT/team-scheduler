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

  describe "new" do
    it "renders new form template" do
      get :new
      response.should render_template("new")
    end

    it "assigns new developer variable" do
      get :new
      assigns(:developer).should.equal? Developer.new
    end
  end

  describe "create" do
    context "when params are correct" do
      def dispatch
        post :create, {:developer => {:name => 'DevName'}}
      end

      it "create developer" do
        dispatch
        developer = assigns(:developer)
        developer.name.should == "DevName"
      end

      it "saves to db" do
        Developer.count.should == 0
        dispatch
        Developer.count.should == 1
      end

      it "redirect to index" do
        dispatch
        response.should redirect_to developers_path
      end
    end

    context "when params are incorrect" do
      it "developer's name is empty" do
        post :create
        response.should render_template("new")
      end
    end
  end
end
