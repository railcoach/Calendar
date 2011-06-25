require 'spec_helper'

describe Location do
  it { should belong_to(:event) }
  it { should validate_presence_of(:country) }

  describe "methods" do
    describe "to_s" do
      it "should work" do
        location = Fabricate(:location)
        location.to_s.should == ("#{location.address}, #{location.town}, #{location.country}")
      end
    end
  end
end
