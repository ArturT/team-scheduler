require 'spec_helper'

describe SessionsController do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }

  describe 'create' do
    context 'has company domain that is in the db' do
      before do
        controller.stub!(:get_domain).and_return(company.domain)
        get :create
      end

      it 'sets session variable to the company name' do
        session[:authenticated].should == company.name
      end

      it 'sets a success message' do
        flash[:success].should == 'Successfully logged into the ' + company.name + ' account.'
      end

      it 'redirects to board view' do
        response.should redirect_to board_index_path
      end
    end

    context 'has company domain that does not exist in the db' do
      before do
        controller.stub!(:get_domain).and_return('invalid.com')
        get :create
      end

      it 'sets an error message' do
        flash[:error].should == 'Cannot login with this Google account.'
      end

      it 'redirects to homepage' do
        response.should redirect_to root_path
      end
    end
  end

  describe 'failure' do
    before do
      get :failure
    end

    it 'sets an error message' do
      flash[:error].should == 'You must be logged in to view this page.'
    end

    it 'redirects to home page' do
      response.should redirect_to root_path
    end
  end

  describe 'logout' do
    before do
      get :logout
    end

    it 'sets authentication to nil' do
      session[:authenticated].should == nil
    end

    it 'sets success message' do
      flash[:success].should == 'You have logged out.'
    end

    it 'redirects to home page' do
      response.should redirect_to root_path
    end

  end
end