require 'spec_helper'

describe SearchController do
  describe "GET search" do
    it "should work" do
      event = Fabricate(:event, :name => 'test')
      Event.should_receive(:search).and_return([event])
      get 'search', :query => 'test'
      assigns[:events].should include(event)
      assigns[:events].length.should be(1)
    end
  end

end
