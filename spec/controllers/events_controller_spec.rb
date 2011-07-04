require 'spec_helper'

describe EventsController do
  include Devise::TestHelpers

  before(:each) do
    @user = Fabricate(:user)
    controller.stub(:current_user).and_return(@user)
    sign_in @user
  end

  let(:event) { mock_model(Event).as_null_object }
  let(:events) { [mock_model(Event).as_null_object] }

  describe "GET index" do
    before :each do
      Event.stub(:by_date).and_return(events)
      get :index
    end

    it { should assign_to(:events) }
  end

  describe "GET new" do
    before :each do
      Event.stub(:new).and_return(event)
      get :new
    end

    it { should assign_to(:event) }
  end

  describe "POST create" do
    context "success"
      before :each do
        Event.stub(:new).and_return(event)
        event.stub(:save).and_return(true)
        post :create, :event => event
      end

      it "should set a flash message" do
        flash[:notice].should_not be_nil
      end
      it { should assign_to(:event).with(event) }
      it { should respond_with(:redirect) }
  end

  describe "GET show" do
    before :each do
      Event.stub(:find).and_return(event)
      get :show, :id => event.id
    end

    it { should assign_to(:event).with(event) }
  end


  describe "GET edit" do
    before :each do
      Event.stub(:find).and_return(event)
      event.stub(:owner).and_return(@user)
      get :edit, :id => event.id
    end

    it { should assign_to(:event).with(event) }
    it { should respond_with(:success) }
  end

  describe "PUT update" do
    before :each do
      Event.stub(:find).and_return(event)
      @user.stub(:is_owner_of?).with(event).and_return(true)
      event.should_receive(:update_attributes).and_return(true)
      put :update, :id => event.id, :event => event
    end


    it { should assign_to(:event).with(event) }
    it { should respond_with(:redirect) }
  end

  describe "GET my_events" do
    before(:each) do
      Event.stub_chain(:future, :by_date, :where).and_return(events)
      get 'my_events'
    end
    
    it { should assign_to(:events) }
    it { should assign_to(:events_grouped_by_month) }
    it { should respond_with(:success) }
  end
end
