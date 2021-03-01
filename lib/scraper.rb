require 'pry'
require 'open-uri'
require 'nokogiri'

class Scraper
  attr_reader :month, :day

  def initialize(month, day)
    @month = month
    @day = day
    @hash = {}
    binding.pry
    obtain_html
  end

  def obtain_html
    index_url = "https://en.wikipedia.org/wiki/Wikipedia:Selected_anniversaries/#{@month}"
    @doc = Nokogiri::HTML(open(index_url))
    binding.pry
  end

  def create_events

    #hash needs to have month, day, year, event description
    hash = {
      :month => @month,
      :day => @day
    }
  end
end
