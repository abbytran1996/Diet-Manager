# Ruby Diet Manager
# Abigail My Tran
# December 3rd, 2016

require './FoodDB'
require './BasicFood'
require './Recipe'
require './Log'
require './LogItem'

food_database = FoodDB.new()
food_log = Log.new()

$stdin.each do |line|
  line.chomp! 
  if line == 'print all'
    print_string = food_database.to_string()
    puts(print_string)

  elsif (line[0..4] == "print" &&  line[-4..-1] != " all")
    food_name = line[6..-1]
    food_database.print_food( food_name )

  elsif line[0..3] == "find"
    found_food = food_database.find( line[5..-1].downcase )
    if (found_food != nil)
      food_database.print_food( found_food )
    end
  elsif line[0..7] == "new food"
    array = line[9..-1].split(',')
    name = array[0]
    calories = array[1]
    food = BasicFood.new( name, calories )
    food_database.add_basic_food( name, food )

  elsif line[0..9] == "new recipe"
    array = line[11..-1].split(',')
    name = array[0]
    ingredients = array[1..-1]
    food = Recipe.new( name, ingredients )
    food_database.add_recipe( name, food )

  elsif line[0..2] == "log"
    array = line[4..-1].split(',')
    food_name = array[0]
    if (array[1] == nil)
      food_date = Date.today
    else
      date_array = array[1].split('/')
      year = date_array[2].to_i
      day = date_array[1].to_i
      month = date_array[0].to_i
      food_date = Date.new(year, month, day)
    end
    food_log.add( food_date, food_name )

  elsif line == "show all"
    food_log.show_all()

  elsif line[0..3] == "show"
    date_string = line[5..-1]
    if (date_string == nil)
      food_date = Date.today
    else
      date_array = date_string.split('/')
      year = date_array[2].to_i
      day = date_array[1].to_i
      month = date_array[0].to_i
      food_date = Date.new(year, month, day)
    end
    food_log.show( food_date )

  elsif line[0..5] == "delete"
    array = line[7..-1].split(',')
    food_name = array[0]
    date_array = array[1].split('/')
    year = date_array[2].to_i
    day = date_array[1].to_i
    month = date_array[0].to_i
    food_date = Date.new(year, month, day)
    food_log.delete(food_date, food_name)
   
    original_log = Log.new().to_log()
    changed = food_log.to_log()
    if (original_log != changed)
      food_log.save( changed )
    end          

  elsif line == "save"
    original_data = FoodDB.new().to_data()
    changed = food_database.to_data()
    if (original_data != changed)
      food_database.save( changed )
    end
    
    original_log = Log.new().to_log()
    changed = food_log.to_log()
    if (original_log != changed)
      food_log.save( changed )
    end

  elsif line  == 'quit'
    original_data = FoodDB.new().to_data()
    changed = food_database.to_data()
    if (original_data != changed)
      food_database.save( changed )
    end
    original_log = Log.new().to_log()
    changed = food_log.to_log()
    if (original_log != changed)
      food_log.save( changed )
    end
    exit
  
  elsif line == "."
    puts("\n")

  else
    puts("None")
  end
end
