require 'spec_helper'

describe ProjectsController do
  describe "index" do
    it "renders index template" do
      get :index
      response.should render_template("index")
    end

    it "assigns projects variable" do
      project = FactoryGirl.build(:project)
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
        post :create, {:project => {:name => 'ProjectName'}}
      end

      it "create project" do
        dispatch
        project = assigns(:project)
        project.name.should == "ProjectName"
      end

      it "saves to db" do
        Project.count.should == 0
        dispatch
        Project.count.should == 1
      end

      it "redirect to index" do
        dispatch
        response.should redirect_to projects_path
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

  describe "delete" do
    it "delete project" do
      create(:project)
      Project.count.should == 1
      post :destroy, {:id => 1}
      Project.count.should == 0
    end
  end
end
