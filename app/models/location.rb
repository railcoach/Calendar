class Location < ActiveRecord::Base
  belongs_to :event
  validates :country, :presence => true
  
  def to_s
    [address,town,country].compact.join(", ")
  end
end
