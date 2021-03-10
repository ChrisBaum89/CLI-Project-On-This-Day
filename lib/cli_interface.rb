require_relative "../lib/scraper.rb"
require_relative "../lib/month.rb"
require_relative "../lib/event.rb"
require 'pry'
require 'time'

#class will allow a user to select a month and day
#class will allow a user to select today
class CommandLineInterface
  attr_reader :month, :day

  def initialize
    months
    @today_month = Month.all[(Time.now().month).to_i - 1] #obtains current month
    @today_day = Time.now().day() #obtains current day number
  end
  #allows for initial questions and obtain user input
  def run
    puts ""
    puts_divider
    puts "By inputing a month and a day, we can learn about notable events that happened on that day!"
    puts "Please enter 1 if you would like to select today's date (#{@today_month.name} #{@today_day})."
    puts "Please enter 2 if you would like to select a month and day."
    puts "Please enter 3 if you would like to exit the program."
    puts_divider
    input = gets.strip #gets user selection
    user_selection(input) #calls method to handle user selection
    output_events unless input == "3" #calls method to output events to CLI
  end

  def user_selection(input)
    if input == "1"
      @month = @today_month
      @day = @today_day
      create_scraper
    elsif input == "2"
      puts "Select a month by entering the number that corresponds with the month:"

      #prints out all of the months
      Month.all.each do |x|
        puts "#{x.number}. #{x.name}"
      end
      puts_divider
      month_number = gets.strip.to_i
      valid_month?(month_number)
      @month = Month.all[month_number.to_i - 1]
      puts "You entered #{@month.name}. Please enter a day of the month."
      puts "Note:  #{@month.name} has #{@month.number_of_days} days."
      @day = gets.strip
      if valid_day?
        create_scraper
      else
        incorrect_selection
      end
    elsif input == "3"
      exit
    else
      incorrect_selection
    end
  end

  def output_events
    puts_divider
    puts "Historical events that occured on #{@month.name} #{@day}:"
    Event.all.each do |x|
      puts "#{x.description}"
      puts ""
    end
    Event.all.clear
    run
  end

  def incorrect_selection
    puts "Selection not available, please try again."
    run
  end

  def create_scraper
    Scraper.new(@month.name, @day)
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
      if x.name == @month.name && (x.number_of_days >= @day.to_i)
        valid_selection << true
      else
        valid_selection << false
      end
    end
    valid_selection.include?(true)
  end

  def puts_divider
    puts "----------------------------------------------------------"
  end

  def valid_month?(month)
    if month < 1 || month > 12
      incorrect_selection
    end
  end


end
