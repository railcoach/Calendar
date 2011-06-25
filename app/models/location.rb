class Location < ActiveRecord::Base
  belongs_to :event
  
  def to_s
    "#{address} - #{town}, #{country}"
  end
end
