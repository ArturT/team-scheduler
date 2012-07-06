require "spec_helper"

describe SchedulesController do
  describe "new" do
    before do
      create(:project)
      create(:developer)
      get :new, :project_id => 1
    end

    it "renders a new template" do
      response.should render_template("new")
    end

    it "passes a project name" do
      project = assigns(:project)
      project.name.should == 'ProjectName'
    end

    it "creates a new schedule object" do
      assigns(:schedule).should be_a_new(Schedule)
    end

    it "passes a list of all developers" do
      devs = assigns(:developers)
      devs.count.should == 1
    end
  end

  describe "create" do
    context "when the parameters are valid" do
      before do
        post :create, :project_id => 1, :schedule => {:project_id => 1, :developer_id => 1, :start_date => "2012-01-01", :end_date => "2012-01-31"}
      end

      it "adds new schedule object" do
        schedule = assigns(:schedule)
        schedule.developer_id.should == 1
        schedule.project_id.should == 1
        schedule.start_date.should == "2012-01-01".to_date
        schedule.end_date.should == "2012-01-31".to_date
      end

      it "redirects to project" do
        response.should redirect_to project_path(1)
      end
    end

    context "when parameters are invalid" do
      before do
        post :create, :project_id => 1, :schedule => {:project_id => 1, :developer_id => 1, :start_date => "2012-01-31", :end_date => "2012-01-01"}
      end

      it "renders new with the values" do
        response.should render_template("new", :project_id => 1)
      end
    end
  end

  describe "edit" do
    before do
      create(:project)
      create(:schedule)
      create(:developer)
      get :edit, :project_id => 1, :id => 1
    end

    it "renders edit" do
      response.should render_template("edit")
    end

    it "has project object" do
      project = assigns(:project)
      project.name.should == "ProjectName"
    end

    it "has schedule object" do
      assigns(:schedule).should be_instance_of(Schedule)
    end

    it "has list of developers" do
      devs = assigns(:developers)
      devs.count.should == 1
    end
  end

  describe "update" do
    context "when the parameters are valid" do
      before do
        create(:schedule)
        post :update, :id => 1, :project_id => 1, :schedule => {:id => 1, :project_id => 1, :developer_id => 1, :start_date => "2012-01-01", :end_date => "2012-01-31"}
      end

      it "finds schedule object after update" do
        schedule = assigns(:schedule)
        schedule.developer_id.should == 1
        schedule.project_id.should == 1
        schedule.start_date.should == "2012-01-01".to_date
        schedule.end_date.should == "2012-01-31".to_date
      end

      it "redirects to project" do
        response.should redirect_to project_path(1)
      end
    end

    context "when the parameters are invalid" do
      before do
        create(:schedule)
        post :update, :id => 1, :project_id => 1, :schedule => {:project_id => 1, :developer_id => 1, :start_date => "2012-01-31", :end_date => "2012-01-01"}
      end

      it "renders edit with the values" do
        response.should render_template("edit")
      end
    end
  end

  describe "destroy" do
    it "deletes schedule" do
      create(:schedule)
      create(:project)
      expect {post :destroy, :id =>1, :project_id => 1 }.to change{Schedule.count}.by(-1)
      response.should redirect_to project_path(1)
    end
  end
end