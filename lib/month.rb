class Month
  attr_reader :name, :number, :number_of_days

  @@all = []
  def initialize(name, number, number_of_days)
    @name = name
    @number = number
    @number_of_days = number_of_days
    @@all << self
  end

  def self.all
    @@all
  end

end
