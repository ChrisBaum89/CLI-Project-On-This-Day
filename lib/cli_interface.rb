require_relative "../lib/scraper.rb"
require_relative "../lib/event.rb"
require 'nokogiri'

#class will allow a user to select a month and day
#class will allow a user to select today
class CommandLineInterface
  def run
    puts "By inputing a month and a day, we can learn about notable events that happened on that day!"
    puts "Please enter 1 if you would like to learn about an event in history today."
    puts "Please enter 2 if you would like to select a month and day."
    input = gets.strip
    user selection
  end

  def user_selection
    if input == 1
      @month = time.month
      @day = time.day
    elsif input == 2
      puts "Select a month:"
      @month = gets.strip
      puts "You selected #{month.capitalize}. Please select a day."
      @day = gets.strip
    else
      incorrect_selection
    end
    Scraper.new(@month, @day)
  end

  def incorrect_selection
    puts "Selection not available, please try again."
    run
  end

end
