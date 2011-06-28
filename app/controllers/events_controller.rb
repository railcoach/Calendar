class EventsController < ApplicationController
  before_filter :authenticate_user!, :only => [:new, :create, :edit, :update, :my_events]
  respond_to :json, :html, :js, :ics

  def index
    @events = Event.future.by_date(params[:year], params[:month], params[:day])
    @events_grouped_by_month = @events.group_by { |x| x.starts_at.strftime('%B') }
    respond_with(@events)
  end

  def my_events
    @events = Event.future.by_date(params[:year], params[:month], params[:day]).where(:user_id => current_user)
    @events_grouped_by_month = @events.group_by { |x| x.starts_at.strftime('%B') }
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
    @event = Event.new(params[:event].merge(:owner => current_user))
    if @event.save
      flash[:notice] = "Your event has been created."
      redirect_to @event, :notice => "Your event has been created."
    else
      render :new, :error => "Something went wrong!"
    end
  end

  def edit
    @event = Event.find(params[:id])
    redirect_to(events_path, :error => 'Hey, this isn\'t your event!' ) and return unless current_user.is_owner_of?(@event)
    respond_with(@event)
  end

  def update
    @event = Event.find(params[:id])
    redirect_to( events_path, :error => 'Unauthorized' ) and return unless current_user.is_owner_of?(@event)
    if @event.update_attributes(params[:event])
      redirect_to @event, :notice => "Your event has been updated."
    else
      render :edit, :error => "Something went wrong updating your event."
    end
  end

end
