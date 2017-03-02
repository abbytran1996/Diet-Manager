# Recipe
# Abigail My Tran
# December 3rd, 2016

class Recipe < Object

  private
  def initialize(name = String.new, ingredients = Array.new)
    @name = name
    @ingredients = ingredients
  end

  public 
  attr_reader :name, :ingredients

end
