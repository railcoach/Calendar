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

    describe "by_date" do
      it "should return objects if year/month/day are passed" do
        event = Fabricate(:event)
        Event.by_date(event.starts_at.year, event.starts_at.month, event.starts_at.day).should include(event)
      end

      it "should return objects if year/month are passed" do
        event = Fabricate(:event)
        Event.by_date(event.starts_at.year, event.starts_at.month).should include(event)
      end

      it "should return objects if year are passed" do
        event = Fabricate(:event)
        Event.by_date(event.starts_at.year).should include(event)
      end

      it "should return self if year is nil" do
        event = Fabricate(:event)
        Event.by_date.should include(event)
      end
      
      it "should be chainable" do
        event = Fabricate(:event)
        Event.by_date(event.starts_at.year).limit(10).should include(event)
      end

      it "should work with string" do
        event = Fabricate(:event)
        Event.by_date(event.starts_at.year.to_s).should include(event)
      end
    end
  end
end
