require 'spec_helper'

describe SchedulesController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project, :developer => developer) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe 'new' do
    before do
      create(:developer, :company => company)
      get :new, :project_id => project.id
    end

    it 'renders a new template' do
      response.should render_template('new')
    end

    it 'passes a project name' do
      assigns(:project).name.should == project.name
    end

    it 'creates a new schedule object' do
      assigns(:schedule).should be_a_new(Schedule)
    end

    it 'passes a list of all developers' do
      assigns(:developers).count.should == 1
    end
  end

  describe 'create' do
    context 'when the parameters are valid' do
      def dispatch
        post :create, :project_id => project.id, :schedule => {:developer_id => developer.id, :project_id => project.id, :start_date => '2012-01-01', :end_date => '2012-01-31', :default_hours => 8}
      end

      it 'adds new schedule object' do
        dispatch
        schedule = assigns(:schedule)
        schedule.developer_id.should == developer.id
        schedule.project_id.should == project.id
        schedule.start_date.should == '2012-01-01'.to_date
        schedule.end_date.should == '2012-01-31'.to_date
        schedule.default_hours.should == 8
      end

      it 'saves the schedule to db' do
        expect { dispatch }.to change { Schedule.count }.by(1)
      end


      it "creates non_default_day objects for weekend set to 0 hours" do
        dispatch
        schedule = assigns(:schedule)
        schedule.non_default_days.count.should == 9
        schedule.non_default_days.each do |non_default_day|
          non_default_day.hours.should == 0
          non_default_day.date.strftime('%a').should match /S[ua][nt]/
        end
      end

      it 'redirects to project' do
        dispatch
        response.should redirect_to project_path(project.id)
      end
    end

    context 'when parameters are invalid' do
      before do
        post :create, :project_id => project.id, :schedule => {:developer_id => developer.id, :project_id => project.id, :start_date => '2012-01-31', :end_date => '2012-01-01'}
      end

      it 'renders new with the values' do
        response.should render_template('new', :project_id => project.id)
      end
    end
  end

  describe 'edit' do
    before do
      get :edit, :project_id => project.id, :id => schedule.id
    end

    it 'renders edit' do
      response.should render_template 'edit'
    end

    it 'has project object' do
      assigns(:project).name.should == 'ProjectName'
    end

    it 'has schedule object' do
      assigns(:schedule).should be_instance_of(Schedule)
    end

    it 'has list of developers' do
      assigns(:developers).count.should == 1
    end
  end

  describe 'update' do
    context 'when the parameters are valid' do
      context 'when start date is later than before' do
        it 'deletes non_default_days before the new start date' do
          create(:non_default_day, :date => Date.today.beginning_of_month, :schedule => schedule)
          post :update, :id => schedule.id, :project_id => project.id, :schedule => {:id => schedule.id, :project_id => project.id, :developer_id => developer.id, :start_date => Date.today.beginning_of_month.next_day, :end_date => Date.today.end_of_month}
          assigns(:schedule).non_default_days.count.should == 0
        end
      end

      context 'when end date is earlier than before' do
        it 'deletes non_default_days after the new end date' do
          create(:non_default_day, :date => Date.today.end_of_month, :schedule => schedule)
          post :update, :id => schedule.id, :project_id => project.id, :schedule => {:id => schedule.id, :project_id => project.id, :developer_id => developer.id, :start_date => Date.today.beginning_of_month, :end_date => Date.today.end_of_month.prev_day}
          assigns(:schedule).non_default_days.count.should == 0
        end
      end

      context 'when both start and end date are changed' do
        it 'deletes non_default_days that are outside the new date range' do
          create(:non_default_day, :date => Date.today.beginning_of_month, :schedule => schedule)
          create(:non_default_day, :date => Date.today.end_of_month, :schedule => schedule)
          post :update, :id => schedule.id, :project_id => project.id, :schedule => {:id => schedule.id, :project_id => project.id, :developer_id => developer.id, :start_date => Date.today.beginning_of_month.next_day, :end_date => Date.today.end_of_month.prev_day}
          assigns(:schedule).non_default_days.count.should == 0
        end
      end
    end

    context 'when the parameters are invalid' do
      it 'renders edit when start date is after end date' do
        post :update, :id => schedule.id, :project_id => project.id, :schedule => {:id => schedule.id, :project_id => project.id, :developer_id => developer.id, :start_date => '2012-01-31', :end_date => '2012-01-01'}
        response.should render_template 'edit'
      end
    end
  end

  describe 'destroy' do
    it 'deletes schedule' do
      schedule = create(:schedule, :developer => developer, :project => project)
      expect { post :destroy, :id => schedule.id, :project_id => project.id }.to change { Schedule.count }.by(-1)
      response.should redirect_to project_path(project.id)
    end
  end
end