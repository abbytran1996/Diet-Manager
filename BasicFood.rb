# Basic Food
# Abigail My Tran
# December 3rd, 2016

class BasicFood < Object

  private

  def initialize(name, calories)
    @name = name
    @calories = calories
  end

  public
  attr_reader :name, :calories

end 

