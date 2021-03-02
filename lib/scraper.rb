require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  attr_reader :month, :day

  def initialize(month, day)
    @month = month
    @day = day
    @hash = {}
    obtain_html
    create_event
  end

  def obtain_html
    #obtains html from Wikipedia which has list of events that occured on a day of the year
    index_url = "https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/#{@month}_#{@day}"
    @doc = Nokogiri::HTML(open(index_url))
  end

  def create_event
    #hash needs to have month, day, year, event description
    #if statement verifies that an event description and year exist
    i = 0
    while @doc.css('div.mw-parser-output ul li')[i] != nil
      if @doc.css('div.mw-parser-output ul li')[i] != nil && year_is_integer?(@doc.css('div.mw-parser-output ul li')[i].children[0].values[1])
        hash = {
          :month => @month,
          :day => @day,
          :year => @doc.css('div.mw-parser-output ul li')[i].children[0].values[1],
          :description => @doc.css('div.mw-parser-output ul li')[i].text
        }
        Event.new(hash)
        #binding.pry
      end
      i += 1
    end
  end

  def year_is_integer?(string)
      string.to_i.to_s == string
  end

end
