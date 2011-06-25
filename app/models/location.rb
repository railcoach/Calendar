class Location < ActiveRecord::Base
  belongs_to :event
  validates :country
  
  def to_s
    if address && town && country
      "#{address} - #{town}, #{country}"
    elsif town && country
      "#{town}, #{country}"
    elsif country
      "#{country}"
    end
  end
end
