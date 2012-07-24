require 'spec_helper'

describe NonDefaultDaysController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }
  let(:non_default_day) { create(:non_default_day, :schedule => schedule) }

  before do
    controller.should_receive(:authenticated)
    session[:authenticated] = company.name
  end

  describe 'change' do
    context 'when id is -1' do
      it 'should redirect to new' do
        get :change, :id => -1, :project_id => project.id, :schedule_id => schedule.id
        response.should redirect_to new_project_schedule_day_path
      end
    end

    context 'when id is valid' do
      it 'should redirect to edit' do
        get :change, :id => non_default_day.id, :project_id => project.id, :schedule_id => schedule.id
        response.should redirect_to edit_project_schedule_day_path
      end
    end
  end

  describe 'new' do
    before do
      get :new, :project_id => project.id, :schedule_id => schedule.id
    end

    it 'renders new form' do
      response.should render_template 'new'
    end

    it 'assigns new non_default_day object' do
      assigns(:non_default_day).should be_a_new(NonDefaultDay)
    end
  end

  describe 'create' do
    context 'when params are valid' do
      def dispatch
        post :create, :project_id => project.id, :schedule_id => schedule.id, :non_default_day => {:schedule_id => schedule.id, :date => Date.today, :hours => 4}
      end

      it 'adds new non_default_day object' do
        dispatch
        non_default_day = assigns(:non_default_day)
        non_default_day.schedule_id.should == schedule.id
        non_default_day.date.should == Date.today
        non_default_day.hours.should == 4
      end

      it 'saves the non_default_day to the database' do
        expect{ dispatch }.to change{ NonDefaultDay.count }.by(1)
      end

      it 'redirects to board index' do
        dispatch
        response.should redirect_to board_index_path
      end
    end

    context 'when hours have not been changed' do
      def dispatch
        post :create, :project_id => project.id, :schedule_id => schedule.id, :non_default_day => {:schedule_id => schedule.id, :date => Date.today, :hours => schedule.default_hours}
      end

      it 'does not save the non_default_day to the database' do
        expect{ dispatch }.to change{ NonDefaultDay.count }.by(0)
      end

      it 'renders new template' do
        dispatch
        response.should render_template 'new'
      end
    end

    context 'when parameters are invalid' do
      it 'renders new page' do
        post :create, :project_id => project.id, :schedule_id => schedule.id, :non_default_day => {:schedule_id => schedule.id, :date => Date.today, :hours => 3}
        response.should render_template 'new'
      end
    end
  end

  describe 'edit' do
    before do
      get :edit, :project_id => project.id, :schedule_id => schedule.id, :id => non_default_day.id
    end

    it 'renders edit template' do
      response.should render_template 'edit'
    end

    it 'has a schedule object' do
      schedule = assigns(:schedule)
      schedule.developer_name.should == developer.name
      schedule.project_name.should == project.name
    end
  end

  describe 'update' do
    context 'if parameters are valid' do
      def dispatch
        post :update, :project_id => project.id, :schedule_id => schedule.id, :id => non_default_day.id, :non_default_day => { :id => non_default_day.id, :schedule_id => schedule.id, :date => Date.today, :hours => 2 }
      end

      it 'create non_default_day object' do
        dispatch
        non_defaut_day = assigns(:non_default_day)
        non_defaut_day.schedule_id.should == schedule.id
        non_defaut_day.date.should == Date.today
        non_defaut_day.hours.should == 2
      end

      it 'updates non_default_day in db' do
        expect{ dispatch }.to change{ NonDefaultDay.find(non_default_day.id).hours }.to(2)
      end

      it 'redirects to board index' do
        dispatch
        response.should redirect_to board_index_path
      end
    end

    context 'when hour set back to default' do
      before do
        @non_default_day = create(:non_default_day)
      end

      def dispatch
        post :update, :project_id => project.id, :schedule_id => schedule.id, :id => @non_default_day.id, :non_default_day => { :id => @non_default_day.id, :schedule_id => schedule.id, :date => Date.today, :hours => schedule.default_hours }
      end

      it 'non default day should be remove' do
        expect{ dispatch }.to change{ NonDefaultDay.count }.by(-1)
      end

      it 'redirects to board index' do
        dispatch
        response.should redirect_to board_index_path
      end
    end

    context 'if parameters are invalid' do
      it 'renders edit template' do
        post :update, :project_id => project.id, :schedule_id => schedule.id, :id => non_default_day.id, :non_default_day => { :id => non_default_day.id, :schedule_id => schedule.id, :date => Date.today, :hours => 3 }
        response.should render_template 'edit'
      end
    end
  end
end