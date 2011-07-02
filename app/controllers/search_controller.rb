class SearchController < ApplicationController
  respond_to :xml, :html, :json
  def search
    @events = Event.search(params[:query])
    @events_grouped_by_month = @events.group_by { |x| x.starts_at.strftime('%B') }
    respond_with(@events)
  end
end
