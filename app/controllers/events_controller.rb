class EventsController < ApplicationController
  respond_to :json, :html, :js

  def index
    @events = Event.all
    respond_with(@events)
  end

  def show
    @event = Event.find(params[:id])
    respond_with(@event)
  end


  def new
    @event = Event.new(params[:event])
    @event.build_location
    respond_with(@event)
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, :notice => "Your event has been created."
    else
      render :new, :error => "Something went wrong!"
    end
  end

  def edit
    @event = Event.find(params[:id])
    respond_with(@event)
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => "Your event has been updated."
    else
      render :edit, :error => "Something went wrong updating your event."
    end
  end

end
