require 'spec_helper'

describe Event do
  it { should have_one(:location) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:starts_at) }
  it { should validate_presence_of(:ends_at) }

  describe "Methods" do
    describe "occures_at" do
      it "should work" do
        event = Fabricate(:event)
        event.occures_at.should match("^#{event.starts_at.strftime("%H:%M %d/%m/%Y")} - #{event.ends_at.strftime("%H:%M %d/%m/%Y")}$")
      end
    end
  end
end
