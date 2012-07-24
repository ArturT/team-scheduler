require 'spec_helper'

describe ProjectsController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe 'index' do
    before do
      @project = create(:project, :company => company)
      get :index
    end

    it 'renders index template' do
      response.should render_template 'index'
    end

    it 'assigns projects variable' do
      assigns(:company).projects.first.should == @project
    end
  end

  describe 'new' do
    before do
      get :new
    end

    it 'renders new form template' do
      response.should render_template 'new'
    end

    it 'assigns new project variable' do
      assigns(:project).should be_a_new(Project)
    end
  end

  describe 'create' do
    context 'when params are correct' do
      def dispatch
        post :create, {:project => {:name => 'ProjectName', :color => '#fff000', :company_id => company.id}}
      end

      it 'create project' do
        dispatch
        assigns(:project).name.should == 'ProjectName'
      end

      it 'saves to db' do
        expect{ dispatch }.to change{Project.count}.by(1)
      end

      it 'redirect to this project' do
        dispatch
        response.should redirect_to project_path(Project.find(:all).last.id)
      end
    end

    context 'when params are incorrect' do
      it 'project name is empty' do
        post :create
        response.should render_template 'new'
      end
    end
  end

  describe 'edit' do
    it 'gets the project from the db' do
      get :edit, {:id => project.id}
      assigns(:project).name.should == 'ProjectName'
    end
  end

  describe 'update' do
    context 'when params are correct' do
      it 'gets project from db' do
        post :update, {:id => project.id}
        assigns(:project).name.should == 'ProjectName'
      end

      def dispatch
        post :update, {:id => project.id, :project => {:name => 'ChangedName', :company_id => company.id}}
      end

      it 'updates project in db' do
        Project.find(project.id).name.should == 'ProjectName'
        dispatch
        Project.find(project.id).name.should == 'ChangedName'
      end
    end

    context 'when params are incorrect' do
      it 'update attributes fails' do
        post :update, {:id => project.id, :project => {:name => '', :company_id => company.id}}
        response.should render_template 'edit'
      end
    end
  end

  describe 'destroy' do
    it 'delete project' do
      project = create(:project, :company => company)
      expect{ post :destroy, :id => project.id }.to change{ Project.count }.by(-1)
    end

    it 'deleted project deleted schedules also' do
      create(:schedule, :developer => developer, :project => project)
      expect{ post :destroy, :id => project.id }.to change{ Schedule.count }.by(-1)
    end
  end

  describe 'show' do
    it 'gets the project object' do
      get :show, :id => project.id
      assigns(:project).should be_instance_of(Project)
    end

    it 'gets list of schedules for this project' do
      create(:schedule, :developer => developer, :project => project)
      get :show, :id => project.id
      assigns(:schedules).count.should == 1
    end
  end
end
