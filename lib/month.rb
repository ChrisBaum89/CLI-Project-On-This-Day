class Month
  attr_reader :name, :number

  @@all = []
  def initialize(name, number, number_of_days)
    @number = number
  end

  def all
    @all << self
  end

end
