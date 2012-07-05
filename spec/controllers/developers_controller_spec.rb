require 'spec_helper'

describe DevelopersController do
  describe "index" do
    it "renders index template" do
      get :index
      response.should render_template("index")
    end

    it "assigns developers variable" do
      developer = FactoryGirl.build(:developer)
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
        expect{ dispatch }.to change {Developer.count }.by(1)
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

  describe "edit" do
    it "gets the developer from the db" do
      FactoryGirl.create(:developer)
      get :edit, {:id => 1}
      developer = assigns(:developer)
      developer.name.should == "DevName"
    end
  end

  describe "update" do
    before do
      FactoryGirl.create(:developer)
    end

    context "when params are correct" do
      it "gets developer from db" do
        post :update, {:id => 1}
        developer = assigns(:developer)
        developer.name.should == "DevName"
      end

      it "updates developer in db" do
        before = Developer.find(1).name
        post :update, {:id => 1, :developer => {:name => "ChangedName"}}
        after = Developer.find(1).name
        before.should_not == after
      end
    end

    context "when params are incorrect" do
      it "update attributes fails" do
        post :update, {:id => 1, :developer => {:name => ""}}
        response.should render_template("edit")
      end
    end
  end

  describe "delete" do
    it "delete developer" do
      FactoryGirl.create(:developer)
      expect{ post :destroy, {:id => 1} }.to change{ Developer.count }.by(-1)
    end
  end
end
