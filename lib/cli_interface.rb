require_relative "../lib/scraper.rb"
require_relative "../lib/month.rb"
require_relative "../lib/event.rb"
#require 'nokogiri'
require 'pry'
require 'time'

#class will allow a user to select a month and day
#class will allow a user to select today
class CommandLineInterface
  attr_reader :month, :day

  def run
    months #calls method which creates the month object for each month
    puts ""
    puts "----------------------------------------------------------"
    puts "By inputing a month and a day, we can learn about notable events that happened on that day!"
    puts "Please enter 1 if you would like to learn about an event in history today."
    puts "Please enter 2 if you would like to select a month and day."
    puts "----------------------------------------------------------"
    input = gets.strip #gets user selection
    user_selection(input) #calls method to handle user selection
    puts "Historical events that occured on #{month} #{day}:"
    output_events #calls method to output events to CLI
  end

  def user_selection(input)
    if input == "1"
      #month_number = Time.now().month #obtains current month number
      @month = Month.all[(Time.now().month).to_i - 1].name
      @day = Time.now().day() #obtains current day number
      create_scraper
    elsif input == "2"
      puts "Select a month by entering the number that corresponds with the month:"
      Month.all.each do |x|
        puts "#{x.number}. #{x.name}"
      end
      puts "----------------------------------------------------------"
      month_number = gets.strip
      @month = Month.all[month_number.to_i - 1].name
      puts "You selected #{@month}. Please select a day of the month."
      @day = gets.strip
      if valid_day?
        create_scraper
      else
        incorrect_selection
      end
    else
      incorrect_selection
    end
  end

  def output_events
    Event.all.each do |x|
      puts "#{x.description}"
      puts ""
    end
    Event.all.clear
  end

  def incorrect_selection
    puts "Selection not available, please try again."
    run
  end

  def create_scraper
    Scraper.new(@month, @day)
  end

  #sets the months
  def months
    Month.new("January", 1, 31)
    Month.new("February", 2, 29)
    Month.new("March", 3, 31)
    Month.new("April", 4, 30)
    Month.new("May", 5, 31)
    Month.new("June", 6, 30)
    Month.new("July", 7, 31)
    Month.new("August", 8, 31)
    Month.new("September", 9, 30)
    Month.new("October", 10, 31)
    Month.new("November", 11, 30)
    Month.new("December", 12, 31)
  end

  def valid_day?
    valid_selection = []
    Month.all.each do |x|
      #binding.pry
      if x.name == @month && (x.number_of_days >= @day.to_i)
        valid_selection << true
      else
        valid_selection << false
      end
    end
    valid_selection.include?(true)
  end
end
