require 'spec_helper'

describe Location do
  it { should belong_to(:event) }

  describe "methods" do
    describe "to_s" do
      location = Fabricate(:location)
      location.to_s.should == ("#{location.address} - #{location.town}, #{location.country}")
    end
  end
end
