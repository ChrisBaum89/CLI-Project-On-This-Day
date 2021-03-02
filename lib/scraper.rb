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
    index_url = "https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/#{@month}_#{@day}"
    @doc = Nokogiri::HTML(open(index_url))
  end

  def create_event
    #hash needs to have month, day, year, event description
    #if statement verifies that an event exists
    i = 8
    while @doc.css('div.mw-parser-output ul li')[i] != nil
      hash = {
        :month => @month,
        :day => @day,
        :year => @doc.css('div.mw-parser-output ul li')[i].children[0].values[1],
        :description => @doc.css('div.mw-parser-output ul li')[i].text
      }
      binding.pry
      #Event.new(hash)
      i += 1
    end
  end

end
