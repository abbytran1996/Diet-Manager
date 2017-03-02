# Log Item
# Abigail My Tran
# December 3rd, 2016

class LogItem < Object

  private

  def initialize (name = String.new, occur = Integer.new)
    @name = name
    @occur = occur
  end

  public
  attr_reader :name, :occur

end

