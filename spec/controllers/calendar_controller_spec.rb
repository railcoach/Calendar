require 'spec_helper'

describe CalendarController do
  describe "GET index" do
    before(:each) do
      get :index
    end

    it { should assign_to(:month) }
    it { should assign_to(:year) }
    it { should assign_to(:shown_month) }
    it { should assign_to(:event_strips) }
    it { should respond_with(:success) }
  end
end
