require_relative "../lib/scraper.rb"
require_relative "../lib/event.rb"
require 'nokogiri'

#class will allow a user to select a month and day
#class will allow a user to select today
class CommandLineInterface
  def run
    months
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
      puts "Select a month by entering the number that coresponds with the month:"
      puts "1. January"
      puts "2. February"
      puts "3. March"
      puts "4. April"
      puts "5. May"
      puts "6. June"
      puts "7. July"
      puts "8. August"
      puts "9. September"
      puts "10. October"
      puts "11. November"
      puts "12. December"
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

  #sets the months
  def months
    Month("January", 1, 31)
    Month("February", 2, 29)
    Month("March", 3, 31)
    Month("April", 4, 30)
    Month("May", 5, 31)
    Month("June", 6, 30)
    Month("July", 7, 31)
    Month("August", 8, 31)
    Month("September", 9, 30)
    Month("October", 10, 31)
    Month("November", 11, 30)
    Month("December", 12, 31)
  end

end
