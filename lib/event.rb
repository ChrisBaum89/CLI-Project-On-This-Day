require 'pry'

class Event
  attr_reader :month, :day, :year, :description

  @@all = []

  def initialize(hash)
    @month = hash(:month)
    @day = hash(:day)
    @year = hash(:year)
    @description = hash(:description)
    @@all << self
  end

  def self.all
    @@all
  end

end
