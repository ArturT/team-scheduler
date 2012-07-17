require 'spec_helper'

describe DevelopersController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe "index" do
    before do
      @developer = create(:developer, :company => company)
      get :index
    end

    it "renders index template" do
      response.should render_template("index")
    end

    it "assigns developers variable" do
      assigns(:company).developers.first.should == @developer
    end
  end

  describe "new" do
    before do
      get :new
    end

    it "renders new form template" do
      response.should render_template("new")
    end

    it "assigns new developer variable" do
      assigns(:developer).should be_a_new(Developer)
    end
  end

  describe "create" do
    context "when params are correct" do
      def dispatch
        post :create, {:developer => {:name => 'CreatedName', :company_id => company.id}}
      end

      it "create developer" do
        dispatch
        assigns(:developer).name.should == "CreatedName"
      end

      it "saves to db" do
        expect{ dispatch }.to change{Developer.count}.by(1)
      end

      it "redirect to index" do
        dispatch
        response.should redirect_to developers_path
      end
    end

    context "when params are incorrect" do
      it "has empty developer name" do
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "edit" do
    it "gets the developer from the db" do
      get :edit, {:id => developer.id}
      assigns(:developer).name.should == "DevName"
    end
  end

  describe "update" do
    context "when params are correct" do
      it "gets developer from db" do
        post :update, {:id => developer.id}
        assigns(:developer).name.should == "DevName"
      end

      def dispatch
        post :update, {:id => developer.id, :developer => {:name => "ChangedName", :company_id => company.id}}
      end

      it "updates developer in db" do
        Developer.find(developer.id).name.should == "DevName"
        dispatch
        Developer.find(developer.id).name.should == "ChangedName"

        #expect { dispatch }.to change(Developer.find(developer.id), :name).from("DevName").to("ChangedName")
      end
    end

    context "when params are incorrect" do
      it "update attributes fails" do
        post :update, {:id => developer.id, :developer => {:name => "", :company_id => company.id}}
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    it "delete developer" do
      developer = create(:developer, :company => company)
      expect{ post :destroy, {:id => developer.id} }.to change{ Developer.count }.by(-1)
    end
  end
end
