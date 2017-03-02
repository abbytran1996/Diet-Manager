# Food Database
# Abigail My Tran
# December 3rd, 2016

require './BasicFood'
require './Recipe'

class FoodDB < Hash

  private
  def initialize()
    @data = Hash.new()
    f = File.open("FoodDB.txt")
    f.each do |line|
      line.chomp!
      if line != ' '
        array = line.split(',')
        type = array[1]
        if type == 'b'
          name = array[0]
          calories = array[2]
          contain = BasicFood.new(name, calories)
          @data.store(name, contain)
        elsif type == 'r'
          name = array[0]
          ingredients = Array.new
          for i in 2..(array.length - 1)
            ingredients.push(array[i])
          end
          contain = Recipe.new(name, ingredients)
          @data.store(name, contain)
        end
      end
    end
  end

  public
  attr_reader :data

###
#PRINT ALL
###
  def to_string()
    print_string = ""
    if data.size == 0
      print_string = 'The food database is empty'
    else
      data.values.each do | contain |
      #Contain is a recipe
        if contain.instance_of? Recipe
          recipe_string = ""
          total_cal = 0
          array = contain.ingredients
          array.each do | name |
          #Find the corresponding basic_food
            food = data[name]
            cal = food.calories
            recipe_string.insert(0, "  #{name}  #{cal}\n" )
            total_cal += cal.to_i
          end
        name = contain.name
        recipe_string.insert(0, "#{name}  #{total_cal}\n")
        print_string.insert(-1, recipe_string)
        elsif contain.instance_of? BasicFood
          num = contain.calories
          name = contain.name
          print_string.insert(-1, "#{name} #{num}\n")
        end
      end
    end
    return print_string
  end


###
#PRINT FOOD
###
  def print_food( food_name)
    if !data.has_key? food_name
      puts ("There is no such food in the database")
    elsif data[food_name].instance_of? Recipe
      print_string = ""
      total_cal = 0
      array = data[food_name].ingredients
      array.each do | name |
      #Find the corresponding basic_food
        food = data[name]
        cal = food.calories
        print_string.insert(0, "  #{name}  #{cal}\n" )
        total_cal += cal.to_i
      end
        print_string.insert(0, "#{food_name}  #{total_cal}\n")
        puts(print_string)
    elsif data[food_name].instance_of? BasicFood
      calo = data[food_name].calories
      puts ("#{food_name} #{calo}")
    end 
  end

###
#FIND PREFIX
###
  def find( prefix )
    found = "no"
    food_list = data.keys
    for i in 0..(food_list.size-1)
      finding = food_list[i].downcase
      if finding.start_with? prefix
        found = "yes"
        return (food_list[i])
      end
    end
    if (found == "no")
      puts ("Can't find such food in the database")
    end
  end


###
# ADD BASIC FOOD
###

 def add_basic_food(name, contain)
   if !data.has_key?(name)
     data.store(name, contain)
   else
     puts "The given food is already in the database"
   end
 end

###
# ADD RECIPE
###
  def add_recipe(name, contain)
    if data.has_key?(name)
      puts "The given recipe is already in the database"
    else
      found = "yes"
      for i in 0..(contain.ingredients.size-1)
        if (!data.has_key?(contain.ingredients[i]))
          puts ("The ingredients is not in the database")
          found = "no"
          break
        end
      end
      if found == "yes"
        data.store(name, contain)
      end
    end
  end

###
# TO DATA
###
  def to_data()
    data_text = ""
    if (data.size == 0)
      return data_text
    else
      data.values.each do | contain |
      #Contain is a Recipe
        if (contain.instance_of? Recipe)
          data_text.insert(-1, "#{contain.name},r")
          ingredient_list = contain.ingredients
          ingredient_list.each do |name|
            data_text.insert(-1, ",#{name}")
          end
          data_text.insert(-1, "\n")
        elsif (contain.instance_of? BasicFood)
          data_text.insert(-1, "#{contain.name},b,#{contain.calories}\n")
        end
      end
      return data_text
    end
  end

###
# SAVE
###
  def save(text)
    File.open("FoodDB.txt", 'w') { |file| file.write(text) }
  end
end

