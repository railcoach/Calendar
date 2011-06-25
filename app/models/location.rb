class Location < ActiveRecord::Base
  belongs_to :event
  validates :country, :presence => true
  
  def to_s
    [address,town.try(:capitalize),country.try(:capitalize)].reject(&:blank?).join(", ")
  end
end
