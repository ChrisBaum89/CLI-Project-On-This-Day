require 'pry'

class Event
  attr_reader :month, :day, :year, :description

  @@all = []

  def initialize(hash)
    @month = hash[:month]
    @day = hash[:day]
    @year = hash[:year]
    @description = hash[:description]
    @@all << self
    sorted
  end

  def self.all
    @@all
  end

#sorts by year to be more intuitive to read
  def sorted
    @@all = @@all.sort_by(&:year)
  end

end
