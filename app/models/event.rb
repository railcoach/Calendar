class Event < ActiveRecord::Base
  default_scope order('starts_at ASC')

  has_one :location, :dependent => :destroy
  accepts_nested_attributes_for :location

  attr_accessor :starts_at_string, :ends_at_string

  validates :name, :presence => true
  validates :description, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true

  after_initialize :parse_dates

  def occures_at
    "#{self.starts_at.strftime("%H:%M %d/%m/%Y")} - #{self.ends_at.strftime("%H:%M %d/%m/%Y")}"
  end

  def self.by_date(year = nil, month = nil, day = nil)
    year = Time.now.year if year.nil?
    year = year.to_i if year
    month = month.to_i if month
    day = day.to_i if day
    if year && month && day
      date = Date.civil(year, month, day)
      return where('DATE(starts_at) = ?', date)
    elsif year && month
      startdate = Date.civil(year, month, 1)
      enddate = Date.civil(year, month, -1)
    elsif year
      startdate = Date.civil(year, 1, 1)
      enddate = Date.civil(year, 12, -1)
    else
      raise "Something went wrong with by_date"
    end
    where(:starts_at => startdate..enddate)
  end

  private

  def parse_dates
    self.starts_at = Chronic.parse(self.starts_at_string) if self.starts_at_string.present?
    self.ends_at = Chronic.parse(self.ends_at_string) if self.starts_at_string.present?
  end
end
