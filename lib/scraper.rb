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
  end

  def obtain_html
    index_url = "https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/#{@month}_#{@day}"
    @doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

  def create_event_hash
    #hash needs to have month, day, year, event description
    hash = {
      :month => @month,
      :day => @day,
      :year => @doc.css('div.mw-parser-output ul li')[8].children[0].values[1],
      :description => @doc.css('div.mw-parser-output ul li')[8].text
    }
    Event.new(hash)
  end

end
