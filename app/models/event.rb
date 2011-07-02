class Event < ActiveRecord::Base
  has_event_calendar :start_at_field => 'starts_at', :end_at_field => 'ends_at'

  belongs_to :owner, :class_name => 'User', :foreign_key => 'user_id'
  default_scope order('starts_at ASC')
  scope :future, where('starts_at >= ?', Time.now - 1.day)


  has_one :location, :dependent => :destroy
  accepts_nested_attributes_for :location

  attr_accessor :starts_at_string, :ends_at_string

  validates :name, :presence => true
  validates :description, :presence => true
  validates :starts_at, :presence => true
  validates :ends_at, :presence => true
  validates :owner, :presence => true

  after_initialize :parse_dates
  #after_initialize :setup_time_strings
  before_save :sanitize_description

  def self.search(params)
    result = params.split(' ').inject(Event.scoped) do |query, param|
      query = query.where('name LIKE ?', param.gsub(/(.+)/, '%\1%'))
    end
  end

  def occures_at
    if self.all_day
      if self.starts_at.to_date == self.ends_at.to_date
        return "all day at #{self.starts_at.strftime("%d/%m/%Y")}"
      else
        return "#{self.starts_at.strftime("%d/%m/%Y")} - #{self.ends_at.strftime("%d/%m/%Y")}"
      end
    else
      return "#{self.starts_at.strftime("%H:%M %d/%m/%Y")} - #{self.ends_at.strftime("%H:%M %d/%m/%Y")}"
    end
  end

  def self.by_date(year = nil, month = nil, day = nil)
    year,month,day = year.year, year.month, year.day if year.is_a?(Time)
    year = Time.now.year if year.nil?
    year = year.to_i if year
    month = month.to_i if month
    day = day.to_i if day
    v = self.unscoped.order('starts_at ASC')
    if year && month && day
      date = Date.civil(year, month, day)
      return v.where('DATE(starts_at) = DATE(?)', date)
    elsif year && month
      startdate = Date.civil(year, month, 1)
      enddate = Date.civil(year, month, -1)
    elsif year
      startdate = Date.civil(year, 1, 1)
      enddate = Date.civil(year, 12, -1)
    else
      raise "Something went wrong with by_date"
    end
    v.where('DATE(starts_at) BETWEEN ? AND ?', startdate, enddate)
  end

  def to_ics
    RiCal.Event do |event|
      event.summary = self.name
      event.description = self.description
      event.dtstart =  self.starts_at
      event.dtend = self.ends_at
      event.location = self.location.to_s
    end
  end
    

  def description_to_html
    RedCloth.new(description).to_html.html_safe
  end

  private

  def parse_dates
    self.starts_at = Chronic.parse(self.starts_at_string) if self.starts_at_string.present?
    self.ends_at = Chronic.parse(self.ends_at_string) if self.starts_at_string.present?
  end

  def sanitize_description
    description.gsub!(/(<.+>)+/, '')
  end

  def setup_time_strings
    if starts_at && ends_at
      self.starts_at_string = starts_at.to_time.to_s if ! self.starts_at_string
      self.ends_at_string = ends_at.to_time.to_s if ! self.ends_at_string
    end
  end

end
