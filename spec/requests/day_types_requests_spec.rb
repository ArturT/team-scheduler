require 'spec_helper'

describe "DayTypes Specs" do

  let(:company) { create(:company) }
  let(:developer) { create(:developer, :company => company) }
  let(:project) { create(:project, :company => company) }
  let(:schedule) { create(:schedule, :project => project) }
  let(:day_type) { create(:day_type, :schedule => schedule) }

  describe "GET /day_types/edit" do
    before do
      create(:day_type, :schedule => schedule)
    end

    it "updates day type" do
      visit edit_day_type_path(:id => schedule.id)
      #page.should 
    end
  end
end