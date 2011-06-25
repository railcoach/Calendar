class Event < ActiveRecord::Base
  has_one :location, :dependent => :destroy
  accepts_nested_attributes_for :location

  validates :name, :presence => true
  validates :description, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true

  def occures_at
    "#{self.starts_at.strftime("%H:%M %d/%m/%Y")} - #{self.ends_at.strftime("%H:%M %d/%m/%Y")}"
  end
end
