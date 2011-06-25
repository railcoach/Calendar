require 'spec_helper'

describe EventsController do
  let(:event) { mock_model(Event).as_null_object }
  let(:events) { [mock_model(Event).as_null_object] }

  describe "GET index" do
    before :each do
      Event.stub(:all).and_return(events)
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
      get :edit, :id => event.id
    end

    it { should assign_to(:event).with(event) }
    it { should respond_with(:success) }
  end

  describe "PUT update" do
    before :each do
      Event.stub(:find).and_return(event)
      put :update, :id => event.id, :event => event
    end


    it { should assign_to(:event).with(event) }
    it { should respond_with(:redirect) }
  end
end
