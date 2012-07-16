require 'spec_helper'

describe ProjectsController do
  before do
    controller.should_receive(:authenticated)
  end

  describe "index" do
    it "renders index template" do
      get :index
      response.should render_template("index")
    end

    it "assigns projects variable" do
      project = build(:project)
      project.save
      get :index
      assigns(:projects).should == [project]
    end
  end

  describe "new" do
    it "renders new form template" do
      get :new
      response.should render_template("new")
    end

    it "assigns new project variable" do
      get :new
      assigns(:project).should be_a_new(Project)
    end
  end

  describe "create" do
    context "when params are correct" do
      def dispatch
        post :create, {:project => {:name => 'ProjectName', :color => '#000000'}}
      end

      it "create project" do
        dispatch
        project = assigns(:project)
        project.name.should == "ProjectName"
      end

      it "saves to db" do
        expect{ dispatch }.to change{Project.count}.by(1)
      end

      it "redirect to this project" do
        dispatch
        response.should redirect_to project_path(1)
      end
    end

    context "when params are incorrect" do
      it "project's name is empty" do
        post :create
        response.should render_template("new")
      end
    end
  end

  describe "edit" do
    it "gets the project from the db" do
      create(:project)
      get :edit, {:id => 1}
      project = assigns(:project)
      project.name.should == "ProjectName"
    end
  end

  describe "update" do
    before do
      create(:project)
    end

    context "when params are correct" do
      it "gets project from db" do
        post :update, {:id => 1}
        project = assigns(:project)
        project.name.should == "ProjectName"
      end

      it "updates project in db" do
        before = Project.find(1).name
        post :update, {:id => 1, :project => {:name => "ChangedName"}}
        after = Project.find(1).name
        before.should_not == after
      end
    end

    context "when params are incorrect" do
      it "update attributes fails" do
        post :update, {:id => 1, :project => {:name => ""}}
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    it "delete project" do
      create(:project)
      expect{ post :destroy, :id => 1 }.to change{ Project.count }.by(-1)
    end

    it "deleted project has no schedules" do
      create(:project)
      create(:developer)
      create(:schedule)
      expect{ post :destroy, :id => 1 }.to change{ Schedule.count }.by(-1)
    end
  end

  describe "show" do
    it "gets the project object" do
      create(:project)
      get :show, :id => 1
      assigns(:project).should be_instance_of(Project)
    end

    it "gets list of schedules for this project" do
      create(:project)
      create(:schedule)
      get :show, :id => 1
      schedules = assigns(:schedules)
      schedules.count.should == 1
    end
  end
end
